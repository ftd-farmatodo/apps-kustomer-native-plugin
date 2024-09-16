package com.example.kustomer_native_plugin

import android.app.Application
import android.util.Log
import android.widget.Toast
import androidx.lifecycle.ViewModel
import com.google.android.gms.tasks.OnCompleteListener
import com.google.firebase.FirebaseApp
import com.google.firebase.messaging.FirebaseMessaging
import com.kustomer.core.models.KusInitialMessage
import com.kustomer.core.models.KusPreferredView
import com.kustomer.core.models.KusResult
import com.kustomer.core.models.chat.KusChatMessageDirection
import com.kustomer.core.models.chat.KusCustomerDescribeAttributes
import com.kustomer.core.models.chat.KusEmail
import com.kustomer.core.models.chat.KusPhone
import com.kustomer.core.utils.log.KusLogOptions
import com.kustomer.ui.Kustomer
import com.kustomer.ui.KustomerOptions
import io.flutter.plugin.common.MethodChannel.Result
import java.util.Locale

class KustomerImpl(private val application: Application, private val kustomerConfig: KustomerConfig) : ViewModel() {

    fun startKustomer(result: Result) {
        setup()
        login(result)
        describeCustomer()
    }

    private fun setup() {
        val options = KustomerOptions.Builder().setBusinessScheduleId("CUSTOM_BUSINESS_SCHEDULE").setBrandId(kustomerConfig.brandId).setUserLocale(Locale.getDefault()).hideNewConversationButton(false).setLogLevel(KusLogOptions.KusLogOptionDebug).hideHistoryNavigation(false).build()
        Kustomer.init(application = application, apiKey = kustomerConfig.apiKey, options = options) {
            Kustomer.getInstance().registerDevice()
            Log.i("KUS_INIT", "Kustomer initialized ${it.dataOrNull}")
        }
    }

    private fun login(result: Result) {
        if (kustomerConfig.token != null && kustomerConfig.email != null && isLogged(kustomerConfig.email) == false) {
            Kustomer.getInstance().logIn(kustomerConfig.token) {
                when (it) {
                    is KusResult.Success -> result.success(true)
                    is KusResult.Error -> result.success(false)
                    else -> {}
                }
            }
        }
    }

    fun openChat() {
        Kustomer.getInstance().open(KusPreferredView.CHAT_HISTORY)
        /*FirebaseMessaging.getInstance().token.addOnCompleteListener(OnCompleteListener { task ->
            if (!task.isSuccessful) {
                Log.w("FIREBASE_KEY", "Fetching FCM registration token failed", task.exception)
                return@OnCompleteListener
            }

            // Get new FCM registration token
            val token = task.result

            // Log and toast
            val msg = "msg_token_fmt, $token"
            Log.d("FIREBASE_KEY", msg)
            Toast.makeText(application, msg, Toast.LENGTH_SHORT).show()
        })*/
    }

    fun startNewConversation() {
        Kustomer.getInstance().startNewConversation(
                initialMessage = KusInitialMessage(kustomerConfig.initialMessage,
                        direction = KusChatMessageDirection.CUSTOMER)
        ) { conversation ->
            when (conversation) {
                is KusResult.Success -> {
                    Log.i("KUS_START_CONVERSATION",
                            "New conversation started. Id: ${conversation.data.id}")
                    describeConversation(conversation.data.id)
                }

                is KusResult.Error ->
                    Log.i("KUS_START_CONVERSATION",
                            "Failed to start conversation: ${conversation.exception.localizedMessage}")

                else -> {}
            }
        }
    }

    private fun isLogged(email: String): Boolean? {
        return Kustomer.getInstance().isLoggedIn(userEmail = email).dataOrNull
    }

    private fun describeCustomer() {
        val attributes = KusCustomerDescribeAttributes(
                emails = listOf(KusEmail(kustomerConfig.email ?: "")),
                phones = listOf(KusPhone(kustomerConfig.phone ?: ""))
        )

        Kustomer.getInstance().describeCustomer(attributes) {
            when (it) {
                is KusResult.Success ->
                    Log.i("KUS_DESCRIBE_CUSTOMER", "Customer described ${it.data}")

                is KusResult.Error ->
                    Log.i("KUS_DESCRIBE_CUSTOMER", "Failed to describe customer: ${it.exception.localizedMessage}")

                else -> {}
            }
        }
    }

    private fun describeConversation(conversationId: String) {
        val attributes: Map<String, Any> =
                mapOf("phone" to (kustomerConfig.phone ?: ""), "email" to (kustomerConfig.email
                        ?: ""))
        Kustomer.getInstance().describeConversation(conversationId, attributes) {
            when (it) {
                is KusResult.Success -> Log.i("KUS_DES_CONVERSATION",
                        "Conversation described ${it.data}")

                is KusResult.Error -> Log.i("KUS_DES_CONVERSATION",
                        "Failed to described conversation: ${it.exception.localizedMessage}")

                else -> {}
            }
        }
    }

    fun logout() {
        Kustomer.getInstance().logOut()
    }
}
