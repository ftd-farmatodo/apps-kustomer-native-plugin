package com.example.kustomer_native_plugin.data

import android.app.Application
import android.content.ContentValues.TAG
import android.util.Log
import androidx.lifecycle.ViewModel
import com.example.kustomer_native_plugin.models.User
import com.kustomer.core.models.KusResult
import com.kustomer.core.models.chat.KusCustomerDescribeAttributes
import com.kustomer.core.utils.log.KusLogOptions
import com.kustomer.ui.Kustomer
import com.kustomer.ui.KustomerOptions
import java.util.Locale

class KustomerImpl(private val appContext : Application, private val api :String, private val user: User, private val brandId : String): ViewModel()  {

    init {

        setup()
    }
   fun setup(){
       val options = KustomerOptions.Builder()
           .setBusinessScheduleId("CUSTOM_BUSINESS_SCHEDULE")
           .setBrandId(brandId)
           .setUserLocale(Locale.getDefault())
           .hideNewConversationButton(false)
           .setLogLevel(KusLogOptions.KusLogOptionErrors)
           .hideHistoryNavigation( false)
       Kustomer.init(application = appContext, apiKey = api, options = options.build()) {
           Log.i(TAG,"Kustomer is initialized ${it.dataOrNull}")
       }
   }
     fun login(user:User){

            if(isLogged(user) == false){
                if(user.token.isNotEmpty()){
                    Kustomer.getInstance().logIn(user.token){
                        when (it) {
                            is KusResult.Success -> it.data
                            is KusResult.Error -> it.exception.localizedMessage
                            else -> {}
                        }
                    }
                }
            }

    }
    fun newConversation(intialMessage: String?) {
        Kustomer.getInstance()
            .openNewConversation(intialMessage)
    }
   private fun isLogged(user: User):Boolean?{
        return Kustomer.getInstance().isLoggedIn(userEmail = user.email).dataOrNull
   }
    fun describeCustomer(attributes: KusCustomerDescribeAttributes){

        Kustomer.getInstance().describeCustomer(attributes){
            when (it) {
                is KusResult.Success -> it.data
                is KusResult.Error -> it.exception.localizedMessage
                else -> {}
            }
        }

    }

    fun describeConversation(conversationId:String,map:Map<String,Any>){

        Kustomer.getInstance()
            .describeConversation(conversationId,
                map){
                when (it) {
                    is KusResult.Success -> it.data
                    is KusResult.Error -> it.exception.localizedMessage
                    else -> {}
                }
            }
    }

}