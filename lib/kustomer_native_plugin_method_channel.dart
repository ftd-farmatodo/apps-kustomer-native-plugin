import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:kustomer_native_plugin/model/conversation_input.dart';
import 'package:kustomer_native_plugin/model/describe_customer.dart';
import 'package:kustomer_native_plugin/model/kustomer_config.dart';
import 'package:kustomer_native_plugin/model/user.dart';

import 'kustomer_native_plugin_platform_interface.dart';

/// An implementation of [KustomerNativePluginPlatform] that uses method channels.
class MethodChannelKustomerNativePlugin extends KustomerNativePluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('kustomer_native_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String> start(KustomerConfig kustomerConfig,User user,ConversationInput? conversationInput,DescribeCustomer? describeCustomer) async {
    var params = <String, String>{
      "kustomerConfigMap": jsonEncode(kustomerConfig.toJson()),
      "userMap": jsonEncode(user.toJson()),
      "conversationInput": jsonEncode(conversationInput?.toJson()),
      "describeCustomer": jsonEncode(describeCustomer?.toJson()),
    };
    String result = await methodChannel.invokeMethod('init',params);
    return result;
  }
   @override
  Future<String> logOut(KustomerConfig kustomerConfig) async {
    var params = <String, String>{
      "kustomerConfigMap": jsonEncode(kustomerConfig.toJson()),
    };
    String result = await methodChannel.invokeMethod('logOut',params);
    return result;
  }
  Future<String> configure(String apiKey) async {
    var params = <String, dynamic>{
      "apiKey": apiKey
    };
    String result = await methodChannel.invokeMethod("configure", params);
    return result;
  }

}
