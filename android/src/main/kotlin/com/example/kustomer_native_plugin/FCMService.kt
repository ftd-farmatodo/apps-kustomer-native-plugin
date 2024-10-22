package com.example.kustomer_native_plugin

import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import com.kustomer.ui.utils.helpers.KusNotificationService

class FCMService : FirebaseMessagingService() {

    override fun onMessageReceived(message: RemoteMessage) {
        super.onMessageReceived(message)
        KusNotificationService.onMessageReceived(remoteMessage = message, context = this)
    }

    override fun onNewToken(token: String) {
        super.onNewToken(token)
    }
}