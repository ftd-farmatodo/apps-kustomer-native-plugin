class ConversationInput {
  String? initialMessage;
  String? title;
  Map<String, dynamic>? map;

  ConversationInput({this.initialMessage, this.title, this.map});

  Map<String, dynamic> toJson() => {
        'initialMessage': initialMessage,
        'title': title,
        'map': map,
      };
}
