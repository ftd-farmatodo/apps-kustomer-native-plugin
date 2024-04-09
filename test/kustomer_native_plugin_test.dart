import 'package:flutter_test/flutter_test.dart';
import 'package:kustomer_native_plugin/kustomer_native_plugin.dart';
import 'package:kustomer_native_plugin/kustomer_native_plugin_platform_interface.dart';
import 'package:kustomer_native_plugin/kustomer_native_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockKustomerNativePluginPlatform
    with MockPlatformInterfaceMixin
    implements KustomerNativePluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final KustomerNativePluginPlatform initialPlatform = KustomerNativePluginPlatform.instance;

  test('$MethodChannelKustomerNativePlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelKustomerNativePlugin>());
  });

  test('getPlatformVersion', () async {
    KustomerNativePlugin kustomerNativePlugin = KustomerNativePlugin();
    MockKustomerNativePluginPlatform fakePlatform = MockKustomerNativePluginPlatform();
    KustomerNativePluginPlatform.instance = fakePlatform;

    expect(await kustomerNativePlugin.getPlatformVersion(), '42');
  });
}
