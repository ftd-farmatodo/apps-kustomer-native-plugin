import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:kustomer_native_plugin/model/kustomer_config.dart';
import 'kustomer_native_plugin_platform_interface.dart';

/// An implementation of [KustomerNativePluginPlatform] that uses method channels.
class MethodChannelKustomerNativePlugin extends KustomerNativePluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('kustomer_native_plugin');

  @override
  Future<bool> start(KustomerConfig config) async {
    var params = <String, dynamic>{
      "apiKey": config.apiKey,
      "brandId": config.brandId,
      "phone": config.user?.phone,
      "email": config.user?.email,
      "token": config.user?.token,
      "initialMessage": config.conversationInput?.initialMessage
    };
    return await methodChannel.invokeMethod("start", params);
  }

  @override
  Future<String> openChat() async {
    return await methodChannel.invokeMethod('openChat');
  }
  
  @override
  Future<String> logOut(KustomerConfig kustomerConfig) async {
    var params = <String, String>{
      "kustomerConfigMap": jsonEncode(kustomerConfig.toJson()),
    };
    return await methodChannel.invokeMethod('logOut',params);
  }
}
