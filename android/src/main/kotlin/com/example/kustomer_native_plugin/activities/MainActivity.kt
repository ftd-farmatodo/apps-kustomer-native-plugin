package com.example.kustomer_native_plugin.activities

import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import android.widget.Toast
import com.example.kustomer_native_plugin.data.KustomerImpl
import com.example.kustomer_native_plugin.models.ConversationInput
import com.example.kustomer_native_plugin.models.DescribeCustomer
import com.example.kustomer_native_plugin.models.KustomerConfig
import com.example.kustomer_native_plugin.models.User
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import com.kustomer.core.models.chat.KusCustomerDescribeAttributes
import com.kustomer.core.models.chat.KusEmail
import com.kustomer.core.models.chat.KusPhone

class MainActivity : AppCompatActivity() {

    private lateinit var kustomer: KustomerImpl
    private var kustomerConfig: KustomerConfig? = null
    private var user: User? = null
    private var conversationInput: ConversationInput? = null
    private var describeCustomer: DescribeCustomer? = null

    companion object {
        const val KUSTOMERCONFIGMAP = "kustomerConfigMap"
        const val USERMAP = "userMap"
        const val DESCRIBECUSTOMER = "describeCustomer"
        const val CONVERSATIONINPUT = "conversationInput"
        const val LOGOUT = "logout"


    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        initArguments()
        initKustomer()

        try {
            finish()

            kustomer.newConversation(conversationInput)


        } catch (e: Exception) {
            Toast.makeText(this, e.message, Toast.LENGTH_SHORT).show()
        }
    }

    private fun initArguments() {

        val conversationInputData = intent.getStringExtra(CONVERSATIONINPUT)
        val userMap = intent.getStringExtra(USERMAP)
        val kustomerConfigMap = intent.getStringExtra(KUSTOMERCONFIGMAP)
        val describeCustomerData = intent.getStringExtra(DESCRIBECUSTOMER)
        val logOut = intent.getBooleanExtra(LOGOUT,false)
        if(logOut){
            kustomer.logout()
        }

        try {
            val userJson = object : TypeToken<User>() {}.getType()
            user = Gson().fromJson(userMap, userJson)
        }catch (e:Exception){
            Log.e("ERROR", "Error deserializando datos del usuario: $e")
        }
        try {
            val conversationInputJson = object : TypeToken<ConversationInput>() {}.getType()
            conversationInput = Gson().fromJson(conversationInputData, conversationInputJson)
        }catch (e:Exception){
            Log.e("ERROR", "Error deserializando datos de conversationInput: $e")
        }
        try {
            val kustomerConfigJson = object : TypeToken<KustomerConfig>() {}.getType()
            kustomerConfig = Gson().fromJson(kustomerConfigMap, kustomerConfigJson)
        }catch (e:Exception){
            Log.e("ERROR", "Error deserializando datos de kustomerConfig: $e")
        }
        try {
            val describeCustomerJson = object : TypeToken<DescribeCustomer>() {}.getType()
            describeCustomer = Gson().fromJson(describeCustomerData, describeCustomerJson)
        }catch (e:Exception){
            Log.e("ERROR", "Error deserializando datos de describerCustomer: $e")
        }

    }

    private fun initKustomer() {
        kustomerConfig?.let {
            kustomer = KustomerImpl(application, it.apiKey, it.brandId!!)
            kustomer.setup()

            user?.let {
                kustomer.login(it)
            }
            describeCustomer?.let { describe ->
                kustomer.describeCustomer(
                    KusCustomerDescribeAttributes(
                        emails = listOf(KusEmail(describe.email)), phones = listOf(
                            KusPhone(describe.phone)
                        ), custom = describe.custom
                    )
                )
            }
        }

    }

}