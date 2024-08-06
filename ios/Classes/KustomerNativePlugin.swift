import Flutter
import UIKit
import KustomerChat

enum KustomerEvents {
  case start
  case newConversation
  case openChat
  case logOut

  var name: String {
    switch self {
      case .start: return "start"
      case .newConversation: return "newConversation"
      case .openChat: return "openChat"
      case .logOut: return "logOut"
    }
  }
}

public class KustomerNativePlugin: NSObject, FlutterPlugin {
  var rootViewController: UIViewController!

  var configuration: KustomerConfiguration?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "kustomer_native_plugin", binaryMessenger: registrar.messenger())
    let instance = KustomerNativePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {

    case KustomerEvents.start.name:
      guard let args = call.arguments as? Dictionary<String, Any> else { return }
      configuration = KustomerConfiguration(args: args)
      configureKustomer(result: result)
      
    case KustomerEvents.newConversation.name:
      guard let configuration = self.configuration else { return }
      startNewConversation(
        initialMessage: configuration.initialMessage,
        phone: configuration.phone,
        email: configuration.email
      )

    case KustomerEvents.openChat.name:
      guard let configuration = self.configuration else { return }
      openChat()

    case KustomerEvents.logOut.name:
      Kustomer.logOut({ error in
        if error != nil {
         print("There was a problem \(error?.localizedDescription ?? "")")
        }
      })

    default:
      result(FlutterError(code: "UNIMPLEMENTED", message: "Method \(call.method) not implemented", details: nil))
    }
  }
}

// MARK: - Private KustomerNativePlugin extension
extension KustomerNativePlugin {

  private func configureKustomer(result: @escaping FlutterResult){
    guard let configuration = self.configuration else { return }

    let options = KustomerOptions()
    options.brandId = configuration.brandId
    options.activeAssistant = .orgDefault
    options.hideNewConversationButtonInClosedChat = false

    Kustomer.configure(apiKey: configuration.apiKey, options: options, launchOptions: nil)

    if let email = configuration.email, let token = configuration.token {
      logIn(email: email, token: token, result: result)
      describeCustomer(phone: configuration.phone, email: email)
    }
  }

  private func logIn(email: String, token: String, result: @escaping FlutterResult) {
    if !userIsLoggedIn(email: email) {
      Kustomer.logIn(jwt: token) { r in
        switch r {
          case .success: result(true)
          case .failure(let error): result(false)
        }
      }
    } else {
      result(true)
    }
  }

  private func userIsLoggedIn(email: String) -> Bool {
    return Kustomer.isLoggedIn(userEmail: email, userId: nil)
  }

  private func describeCustomer(phone: String?, email: String?) {
    Kustomer.chatProvider.describeCurrentCustomer(phone: phone, email: email) { result in
      switch result {
        case .success:
          print("Customer described")
        case .failure(let error):
          print("Failed to describe conversation: \(error.localizedDescription)")
      }
    }
  }

  private func openChat() {
    Kustomer.show(preferredView: .chatHistory)
  }

  private func startNewConversation(initialMessage: String?, phone: String?, email: String?) {
    if let safeInitialMessage = initialMessage {
      Kustomer.startNewConversation(initialMessage: KUSInitialMessage(body: safeInitialMessage, direction: .user), afterCreateConversation: { conversation in
        print("New conversation created. Conversation id is \(conversation.id ?? "")")
        self.describeConversation(conversationId: conversation.id, phone: phone, email: email)
      }, animated: true)
    } else {
        Kustomer.show()
    }
  }

  func describeConversation(conversationId: String?, phone: String?, email: String?) {
    var attributes = [String:Any]()
    attributes["phone"] = phone
    attributes["email"] = email

    guard let conversationId = conversationId else { return }
    Kustomer.chatProvider.describeConversation(conversationId: conversationId, attributes: attributes) { result in
      switch result {
        case .success:
          print("Conversation described")
        case .failure(let error):
          print(error.localizedDescription)
      }
    }
  }
}
