import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

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
  Future<String> configure(String apiKey) async {
    var params = <String, dynamic>{
      "apiKey": apiKey
    };
    String result = await methodChannel.invokeMethod("configure", params);
    return result;
  }

}
