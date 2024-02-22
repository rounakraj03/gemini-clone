import 'dart:convert';

import 'package:client/network/models/chat_model.dart';

class GeminiNewChatRequest {
  String new_message;
  List<GeminiChatModel> old_message;

  GeminiNewChatRequest({
    required this.new_message,
    required this.old_message,
  });

  Map<String, dynamic> toMap() {
    return {
      'new_message': new_message,
      'old_message': old_message.map((x) => x.toMap()).toList(),
    };
  }

  factory GeminiNewChatRequest.fromMap(Map<String, dynamic> map) {
    return GeminiNewChatRequest(
      new_message: map['new_message'] ?? '',
      old_message: List<GeminiChatModel>.from(
          map['old_message']?.map((x) => GeminiChatModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory GeminiNewChatRequest.fromJson(String source) =>
      GeminiNewChatRequest.fromMap(json.decode(source));
}

class ChatGPTNewChatRequest {
  String new_message;
  List<ChatGPTChatModel> old_message;

  ChatGPTNewChatRequest({
    required this.new_message,
    required this.old_message,
  });

  Map<String, dynamic> toMap() {
    return {
      'new_message': new_message,
      'old_message': old_message.map((x) => x.toMap()).toList(),
    };
  }

  factory ChatGPTNewChatRequest.fromMap(Map<String, dynamic> map) {
    return ChatGPTNewChatRequest(
      new_message: map['new_message'] ?? '',
      old_message: List<ChatGPTChatModel>.from(
          map['old_message']?.map((x) => ChatGPTChatModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatGPTNewChatRequest.fromJson(String source) =>
      ChatGPTNewChatRequest.fromMap(json.decode(source));
}
