import 'dart:convert';

class ChatGPTNewChatResponse {
  String data;
  String chatId;
  ChatGPTNewChatResponse({
    required this.data,
    required this.chatId,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': data,
      'chatId': chatId,
    };
  }

  factory ChatGPTNewChatResponse.fromMap(Map<String, dynamic> map) {
    return ChatGPTNewChatResponse(
      data: map['data'] ?? '',
      chatId: map['chatId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatGPTNewChatResponse.fromJson(String source) => ChatGPTNewChatResponse.fromMap(json.decode(source));
}
