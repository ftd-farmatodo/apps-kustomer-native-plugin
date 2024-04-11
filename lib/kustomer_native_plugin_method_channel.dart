import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
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
  Future<String> start(KustomerConfig kustomerConfig,User user,String message) async {
    var params = <String, dynamic>{
      "kustomerConfigMap": kustomerConfig.toJson(),
      "userMap": user.toJson(),
      "message": message,
    };
    String result = await methodChannel.invokeMethod('init',params);
    return result;
  }
}
