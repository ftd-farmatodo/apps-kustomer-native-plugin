import Flutter
import UIKit
import KustomerChat

public class KustomerNativePlugin: NSObject, FlutterPlugin {
  var rootViewController: UIViewController!

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "kustomer_native_plugin", binaryMessenger: registrar.messenger())
    let instance = KustomerNativePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "configure":
      if rootViewController == nil {
        rootViewController = UIApplication.shared.keyWindow?.rootViewController
        }
      if let arguments = call.arguments as? Dictionary<String, Any>, 
         let apiKey = arguments["apiKey"] as? String {
          Kustomer.configure(apiKey: apiKey, options: nil, launchOptions: nil)
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
