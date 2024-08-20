// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'package:kustomer_native_plugin/model/kustomer_config.dart';
import 'kustomer_native_plugin_platform_interface.dart';

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
