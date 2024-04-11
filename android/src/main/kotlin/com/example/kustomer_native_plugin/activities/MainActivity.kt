package com.example.kustomer_native_plugin.activities

import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import android.widget.Toast
import com.example.kustomer_native_plugin.data.KustomerImpl
import com.example.kustomer_native_plugin.databinding.ActivityMainBinding
import com.example.kustomer_native_plugin.models.KustomerConfig
import com.example.kustomer_native_plugin.models.User
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken

class MainActivity : AppCompatActivity() {

    private lateinit var kustomer: KustomerImpl
    private lateinit var kustomerConfig: KustomerConfig
    private lateinit var user : User
    private lateinit var intialMessage:String

    companion object{
        const val KUSTOMERCONFIGMAP = "kustomerConfigMap"
        const val USERMAP = "userMap"
        const val MESSAGE = "message"


    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        initArguments()
        initKustomer()

        try {
            finish()
            kustomer.newConversation(intialMessage)
        }catch (e:Exception){
            Toast.makeText(this, e.message, Toast.LENGTH_SHORT).show()
        }
    }

    private fun initArguments(){
        intialMessage = intent.getStringExtra(MESSAGE) ?: ""
        val userMap = intent.getStringExtra(USERMAP)
        val kustomerConfigMap = intent.getStringExtra(KUSTOMERCONFIGMAP)

        try{
            val userJson = object : TypeToken<User>() {}.getType()
            user = Gson().fromJson(userMap, userJson)

            val  kustomerConfigJson = object : TypeToken<KustomerConfig>() {}.getType()
            kustomerConfig = Gson().fromJson(kustomerConfigMap, kustomerConfigJson)
        }catch (_:Exception){ }
    }
    private fun initKustomer(){
        kustomer = KustomerImpl(application,kustomerConfig.apiKey,user,kustomerConfig.brandId!!)
        kustomer.setup()
        kustomer.login(user)

    }

}