import 'package:apps_kustomer_native_plugin/kustomer.dart';

class Kustomer {

  static Future<bool> start(KustomerConfig config) async {
    return await KustomerNativePluginPlatform.instance.start(config);
  }

  static Future<String?> openChat() async {
    return await KustomerNativePluginPlatform.instance.openChat();
  }
  
  static Future<String> logOut(KustomerConfig kustomerConfig) async {
    return await KustomerNativePluginPlatform.instance.logOut(kustomerConfig);
  }
}
