import 'dart:convert';

import 'package:client/network/models/chat_model.dart';

class DrawerRequest {
  String userId;

  DrawerRequest({
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
    };
  }

  factory DrawerRequest.fromMap(Map<String, dynamic> map) {
    return DrawerRequest(
      userId: map['userId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DrawerRequest.fromJson(String source) =>
      DrawerRequest.fromMap(json.decode(source));
}

class GeminiDrawerResponse {
  String chatId;
  String heading;
  List<GeminiChatModel> chatHistory;
  GeminiDrawerResponse({
    required this.chatId,
    required this.heading,
    required this.chatHistory,
  });

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'heading': heading,
      'chatHistory': chatHistory.map((x) => x.toMap()).toList(),
    };
  }

  factory GeminiDrawerResponse.fromMap(Map<String, dynamic> map) {
    return GeminiDrawerResponse(
      chatId: map['chatId'] ?? '',
      heading: map['heading'] ?? '',
      chatHistory: List<GeminiChatModel>.from(
          map['chatHistory']?.map((x) => GeminiChatModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory GeminiDrawerResponse.fromJson(String source) =>
      GeminiDrawerResponse.fromMap(json.decode(source));
}

class ChatGPTDrawerResponse {
  String chatId;
  String heading;
  List<ChatGPTChatModel> chatHistory;
  ChatGPTDrawerResponse({
    required this.chatId,
    required this.heading,
    required this.chatHistory,
  });

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'heading': heading,
      'chatHistory': chatHistory.map((x) => x.toMap()).toList(),
    };
  }

  factory ChatGPTDrawerResponse.fromMap(Map<String, dynamic> map) {
    return ChatGPTDrawerResponse(
      chatId: map['chatId'] ?? '',
      heading: map['heading'] ?? '',
      chatHistory: List<ChatGPTChatModel>.from(
          map['chatHistory']?.map((x) => ChatGPTChatModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatGPTDrawerResponse.fromJson(String source) =>
      ChatGPTDrawerResponse.fromMap(json.decode(source));
}

class ClaudeDrawerResponse {
  String chatId;
  String heading;
  List<ClaudeChatModel> chatHistory;
  ClaudeDrawerResponse({
    required this.chatId,
    required this.heading,
    required this.chatHistory,
  });

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'heading': heading,
      'chatHistory': chatHistory.map((x) => x.toMap()).toList(),
    };
  }

  factory ClaudeDrawerResponse.fromMap(Map<String, dynamic> map) {
    return ClaudeDrawerResponse(
      chatId: map['chatId'] ?? '',
      heading: map['heading'] ?? '',
      chatHistory: List<ClaudeChatModel>.from(
          map['chatHistory']?.map((x) => ClaudeChatModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ClaudeDrawerResponse.fromJson(String source) =>
      ClaudeDrawerResponse.fromMap(json.decode(source));
}
