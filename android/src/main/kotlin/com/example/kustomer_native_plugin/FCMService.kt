package com.example.kustomer_native_plugin

import android.app.TaskStackBuilder
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import com.kustomer.ui.utils.helpers.KusNotificationService

class FCMService : FirebaseMessagingService() {

    override fun onMessageReceived(message: RemoteMessage) {
        super.onMessageReceived(message)

        //Push notification received
        val isKustomerPush = KusNotificationService.onMessageReceived(remoteMessage = message, context = this, customBackStack = TaskStackBuilder.create(this))
        if (isKustomerPush) {
            //Do nothing
        }
    }
}