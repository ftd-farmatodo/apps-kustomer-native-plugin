import 'package:kustomer_native_plugin/kustomer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockKustomerNativePluginPlatform
    with MockPlatformInterfaceMixin
    implements KustomerNativePluginPlatform {
  

  @override
  Future<String> logOut(KustomerConfig kustomerConfig) {
    throw UnimplementedError();
  }
 
  @override
  Future<bool> start(KustomerConfig config) {
    throw UnimplementedError();
  }
  
  @override
  Future<String> openChat() {
    throw UnimplementedError();
  }
}

void main() {
  final KustomerNativePluginPlatform initialPlatform = KustomerNativePluginPlatform.instance;

  test('$MethodChannelKustomerNativePlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelKustomerNativePlugin>());
  });
}
