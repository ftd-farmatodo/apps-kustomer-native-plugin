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
      guard let args = call.arguments as? Dictionary<String, Any>,
            let apiKey = args["apiKey"] as? String,
            let brandId = args["brandId"] as? String,
            let email = args["email"] as? String, 
            let token = args["token"] as? String,
            let initialMessage = args["initialMessage"] as? String? else { return }

      let options = KustomerOptions()
      options.activeAssistant = .orgDefault
      options.brandId = brandId
      options.hideNewConversationButtonInClosedChat = true

      Kustomer.configure(apiKey: apiKey, options: options, launchOptions: nil)
      logIn(email: email, token: token)
      startNewConversation(initialMessage: initialMessage)

    case "logOut":
      Kustomer.logOut({ error in
        if error != nil {
         print("There was a problem \(error?.localizedDescription ?? "")")
        }
      })

    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func logIn(email: String, token: String) {
    if !userIsLoggedIn(email: email) {
      Kustomer.logIn(jwt: token) { result in
        switch result {
        case .success:
          print("Login success")
        case .failure(let error):
          print("There was a problem \(error.localizedDescription)")
        }
      }
    }
  }

  private func userIsLoggedIn(email: String) -> Bool {
    return Kustomer.isLoggedIn(userEmail: email, userId: nil)
  }

  private func startNewConversation(initialMessage: String?) {
    if let safeInitialMessage = initialMessage {
      Kustomer.startNewConversation(initialMessage: KUSInitialMessage(body: safeInitialMessage, direction: .user), afterCreateConversation: { conversation in
        print("New conversation created. Conversation id is \(conversation.id ?? "")") }, animated: true)
    } else {
        Kustomer.show()
    }
  }
}
