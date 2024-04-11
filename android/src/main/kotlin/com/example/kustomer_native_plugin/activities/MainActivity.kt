package com.example.kustomerchat.ui

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.navigation.findNavController
import androidx.navigation.ui.AppBarConfiguration
import androidx.navigation.ui.navigateUp
import android.view.Menu
import android.view.MenuItem
import android.widget.Toast
import com.example.kustomerchat.R
import com.example.kustomerchat.databinding.ActivityMainBinding
import com.example.kustomerchat.ui.data.KustomerImpl
import com.example.kustomerchat.ui.models.User
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken

class MainActivity : AppCompatActivity() {

    private lateinit var appBarConfiguration: AppBarConfiguration
    private lateinit var binding: ActivityMainBinding
    private lateinit var kustomer: KustomerImpl
    private var user : User? = User(email = "omar.paba@farmatodo.com",token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHRlcm5hbElkIjoiNTU3MzAyIiwiaWF0IjoxNzEwODU4NDAxLCJlbWFpbCI6Im9tYXIucGFiYUBmYXJtYXRvZG8uY29tIn0.f4Mq9QclwB1f5SdAH_-iuBL9TwKn90VuHSgU87LWPMo")
    private var brandId : String? = "6406563db1e150b1e83fc134"
    private var apiKey : String? = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1ZGY1YTdhZWFhY2VhMDcxMjhmZGY5NCIsInVzZXIiOiI2NWRmNWE3OTYyNjE1ODIxN2Y1ODlmNjUiLCJvcmciOiI2NDA2NTYyYTdhNmI4NmZkMjgyYmNhM2IiLCJvcmdOYW1lIjoienp6LWZhcm1hdG9kby1qZXNzeSIsInVzZXJUeXBlIjoibWFjaGluZSIsInBvZCI6InByb2QxIiwicm9sZXMiOlsib3JnLnRyYWNraW5nIl0sImF1ZCI6InVybjpjb25zdW1lciIsImlzcyI6InVybjphcGkiLCJzdWIiOiI2NWRmNWE3OTYyNjE1ODIxN2Y1ODlmNjUifQ.qt7Jr8lAIpYOFCLO3HVqUxFaiVmzV78trlY9-ak0huw"
    private var intialMessage:String? = "Hola en que te puedo ayudar"

    companion object{
        const val KUSTOMER_API_KEY = "KUSTOMER_API_KEY"
        const val CUSTOM_BRAND_ID = "CUSTOM_BRAND_ID"
        const val USER_INFO = "USER_INFO"
        const val INITIAL_MESSAGE = "INITIAL_MESSAGE"

    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        initArguments()
        kustomer = KustomerImpl(application,apiKey!!,user!!,brandId!!)
        //binding = ActivityMainBinding.inflate(layoutInflater)
        //setContentView(binding.root)

        //setSupportActionBar(binding.toolbar)

        kustomer.setup()
        kustomer.addCloseable {  }
        kustomer.login(user!!)

        try {
            finish()
            kustomer.newConversation(intialMessage)
        }catch (e:Exception){
            Toast.makeText(this, e.message, Toast.LENGTH_SHORT).show()
        }
        /*binding.fab.setOnClickListener { view ->
            try {
                kustomer.newConversation()
            }catch (e:Exception){
                Toast.makeText(this, e.message, Toast.LENGTH_SHORT).show()
            }

        }*/

    }

    override fun onBackPressed() {
        super.onBackPressed()
        var x = ""
    }

    private fun initArguments(){
        intent.getStringExtra(KUSTOMER_API_KEY)?.let {api->
          apiKey = api
        }
        intent.getStringExtra(CUSTOM_BRAND_ID)?.let {brand->
            brandId = brand
        }
        intent.getStringExtra(USER_INFO)?.let {userJson->
            if (userJson.isNotEmpty()) {
                val gson = Gson()
                val type = object : TypeToken<User>() {}.type
                user = gson.fromJson(userJson, type)
            }
        }
        intent.getStringExtra(INITIAL_MESSAGE)?.let { message->
            intialMessage = message
        }
    }
}