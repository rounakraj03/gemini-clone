import 'dart:convert';

class NewChatResponse {
  String data;
  String chatId;
  NewChatResponse({
    required this.data,
    required this.chatId,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': data,
      'chatId': chatId,
    };
  }

  factory NewChatResponse.fromMap(Map<String, dynamic> map) {
    return NewChatResponse(
      data: map['data'] ?? '',
      chatId: map['chatId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NewChatResponse.fromJson(String source) =>
      NewChatResponse.fromMap(json.decode(source));
}
