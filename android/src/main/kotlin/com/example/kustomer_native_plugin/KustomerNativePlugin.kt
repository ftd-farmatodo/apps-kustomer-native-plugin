package com.example.kustomer_native_plugin


import android.app.Activity
import android.content.Context
import android.content.Intent
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry

/** KustomerNativePlugin */
class KustomerNativePlugin : FlutterPlugin, MethodCallHandler, ActivityAware,
        PluginRegistry.ActivityResultListener {

    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private var binding: ActivityPluginBinding? = null
    private var activity: Activity? = null

    private var kustomerImpl: KustomerImpl? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "kustomer_native_plugin")
        channel.setMethodCallHandler(this)
        this.context = flutterPluginBinding.applicationContext
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        binding.addActivityResultListener(this)
        this.binding = binding
        this.activity = binding.getActivity()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        binding.addActivityResultListener(this)
        this.binding = binding
        this.activity = binding.getActivity()
    }

    override fun onDetachedFromActivityForConfigChanges() {
        this.binding = null
    }

    override fun onDetachedFromActivity() {
        this.binding = null
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        return false
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            KustomerChannelMethods.START.value -> {
                val arguments = call.arguments as? Map<String, Any?>
                arguments?.let { args ->
                    val kustomerConfig = KustomerConfig.fromMap(args)
                    startKustomer(kustomerConfig, result)
                }
            }

            KustomerChannelMethods.OPEN_CHAT.value -> kustomerImpl?.openChat()

            KustomerChannelMethods.NEW_CONVERSATION.value -> kustomerImpl?.startNewConversation()

            KustomerChannelMethods.LOGOUT.value -> kustomerImpl?.logout()

            else -> result.notImplemented()
        }
    }

    private fun startKustomer(kustomerConfig: KustomerConfig, result: Result) {
        this.activity?.let {
            kustomerImpl = KustomerImpl(it.application, kustomerConfig)
        }
        kustomerImpl?.startKustomer(result)
    }

}

enum class KustomerChannelMethods(val value: String) {
    START("start"),
    NEW_CONVERSATION("newConversation"),
    OPEN_CHAT("openChat"),
    LOGOUT("logOut")
}
