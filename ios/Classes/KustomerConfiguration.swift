
struct KustomerConfiguration {

    var apiKey: String
    var brandId: String
    var phone: String?
    var email: String?
    var token: String?
    var initialMessage: String?

    init(args: Dictionary<String, Any>) {
        apiKey = args["apiKey"] as? String ?? ""
        brandId = args["brandId"] as? String ?? ""
        phone = args["phone"] as? String
        email = args["email"] as? String
        token = args["token"] as? String
        initialMessage = args["initialMessage"] as? String ?? ""
    }
}