import 'package:kustomer_native_plugin/kustomer.dart';

class KustomerConfig {
  String brandId;
  String apiKey;
  KustomerUser? user;
  ConversationInput? conversationInput;

  KustomerConfig({
    required this.brandId,
    required this.apiKey,
    this.user,
    this.conversationInput
  });

  Map<String, dynamic> toJson() => {
        'brandId': brandId,
        'apiKey': apiKey,
        'user': user?.toJson(),
        'conversationInput': conversationInput?.toJson(),
      };
}
