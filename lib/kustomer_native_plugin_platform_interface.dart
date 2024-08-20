import 'package:apps_kustomer_native_plugin/kustomer.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

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

  Future<bool> start(KustomerConfig config) {
    throw UnimplementedError('configure() has not been implemented.');
  }

  Future<String> openChat() async {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  
  Future<String> logOut(KustomerConfig kustomerConfig) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }  
}
