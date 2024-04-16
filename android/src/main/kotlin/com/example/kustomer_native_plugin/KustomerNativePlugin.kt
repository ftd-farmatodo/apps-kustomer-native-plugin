package com.example.kustomer_native_plugin

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.util.Log
import androidx.core.content.ContextCompat.startActivity
import com.example.kustomer_native_plugin.activities.MainActivity
import com.example.kustomer_native_plugin.activities.MainActivity.Companion.CONVERSATIONINPUT
import com.example.kustomer_native_plugin.activities.MainActivity.Companion.DESCRIBECUSTOMER
import com.example.kustomer_native_plugin.activities.MainActivity.Companion.KUSTOMERCONFIGMAP
import com.example.kustomer_native_plugin.activities.MainActivity.Companion.USERMAP


import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.MethodChannel.Result
import java.io.Serializable

/** KustomerNativePlugin */
class KustomerNativePlugin: FlutterPlugin, MethodCallHandler,ActivityAware,PluginRegistry.ActivityResultListener {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context: Context
  private var binding: ActivityPluginBinding? = null
  private var activity: Activity? = null

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "kustomer_native_plugin")
    channel.setMethodCallHandler(this)
  }
  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    binding.addActivityResultListener(this)
    this.binding = binding
    this.activity = binding.getActivity();
  }
  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    binding.addActivityResultListener(this)
    this.binding = binding
    this.activity = binding.getActivity();
  }
  override fun onDetachedFromActivityForConfigChanges() {
    this.binding = null
  }

  override fun onDetachedFromActivity() {
    this.binding = null
  }
  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    }else if(call.method == "init" ){
      val userMap = call.argument<String>(USERMAP)
      val kustomerConfigMap = call.argument<String>(KUSTOMERCONFIGMAP)
      val conversationInputData = call.argument<String>(CONVERSATIONINPUT)
      val describeCustomerData = call.argument<String>(DESCRIBECUSTOMER)

      this.activity?.let {

        val intent = Intent(it, MainActivity::class.java)
        val bundle = Bundle()
        bundle.putSerializable(USERMAP, userMap.toString())
        Log.i("MAP", kustomerConfigMap.toString())
        Log.i("CONVERSATIONINPUT", conversationInputData.toString())
        bundle.putSerializable(CONVERSATIONINPUT, conversationInputData.toString())
        bundle.putSerializable(KUSTOMERCONFIGMAP, kustomerConfigMap.toString())
        bundle.putSerializable(DESCRIBECUSTOMER, describeCustomerData.toString())
        intent.putExtras(bundle)
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        startActivity(it.applicationContext,intent,null)
      }

    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
    return false
  }
}
