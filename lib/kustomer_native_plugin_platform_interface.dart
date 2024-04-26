import 'package:kustomer_native_plugin/model/conversation_input.dart';
import 'package:kustomer_native_plugin/model/describe_customer.dart';
import 'package:kustomer_native_plugin/model/kustomer_config.dart';
import 'package:kustomer_native_plugin/model/user.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'kustomer_native_plugin_method_channel.dart';

abstract class KustomerNativePluginPlatform extends PlatformInterface {
  /// Constructs a KustomerNativePluginPlatform.
  KustomerNativePluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static KustomerNativePluginPlatform _instance = MethodChannelKustomerNativePlugin();

  /// The default instance of [KustomerNativePluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelKustomerNativePlugin].
  static KustomerNativePluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [KustomerNativePluginPlatform] when
  /// they register themselves.
  static set instance(KustomerNativePluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String> start(KustomerConfig kustomerConfig,User user,ConversationInput? conversationInput,DescribeCustomer? describeCustomer) async {
     throw UnimplementedError('platformVersion() has not been implemented.');
  }
  
  Future<String> logOut(KustomerConfig kustomerConfig) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String> configure(String apiKey, String brandId, String email, String token, String? initialMessage) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
