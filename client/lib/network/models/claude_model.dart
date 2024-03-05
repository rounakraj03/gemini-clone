import 'dart:convert';

import 'package:client/network/models/chat_model.dart';

class ClaudeNextChatResponse {
  String chatId;
  String userId;
  String? heading;
  List<ClaudeChatModel> chatHistory;
  ClaudeNextChatResponse({
    required this.chatId,
    required this.userId,
    this.heading,
    required this.chatHistory,
  });

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'userId': userId,
      'heading': heading,
      'chatHistory': chatHistory.map((x) => x.toMap()).toList(),
    };
  }

  factory ClaudeNextChatResponse.fromMap(Map<String, dynamic> map) {
    return ClaudeNextChatResponse(
      chatId: map['chatId'] ?? '',
      userId: map['userId'] ?? '',
      heading: map['heading'],
      chatHistory: List<ClaudeChatModel>.from(
          map['chatHistory']?.map((x) => ClaudeChatModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ClaudeNextChatResponse.fromJson(String source) =>
      ClaudeNextChatResponse.fromMap(json.decode(source));
}
