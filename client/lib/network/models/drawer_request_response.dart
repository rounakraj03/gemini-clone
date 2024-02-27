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
  String id;
  String userId;
  String heading;
  List<GeminiChatModel> chatHistory;
  GeminiDrawerResponse({
    required this.id,
    required this.userId,
    required this.heading,
    required this.chatHistory,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'userId': userId,
      'heading': heading,
      'chatHistory': chatHistory.map((x) => x.toMap()).toList(),
    };
  }

  factory GeminiDrawerResponse.fromMap(Map<String, dynamic> map) {
    return GeminiDrawerResponse(
      id: map['_id'] ?? '',
      userId: map['userId'] ?? '',
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
  String userId;
  String heading;
  List<ChatGPTChatModel> chatHistory;
  ChatGPTDrawerResponse({
    required this.userId,
    required this.heading,
    required this.chatHistory,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'heading': heading,
      'chatHistory': chatHistory.map((x) => x.toMap()).toList(),
    };
  }

  factory ChatGPTDrawerResponse.fromMap(Map<String, dynamic> map) {
    return ChatGPTDrawerResponse(
      userId: map['userId'] ?? '',
      heading: map['heading'] ?? '',
      chatHistory: (map['chatHistory'] as List<dynamic>?)
          ?.map((chatMap) => ChatGPTChatModel.fromMap(chatMap as Map<String, dynamic>))
          .toList() ?? [],
    );
  }


  String toJson() => json.encode(toMap());

  factory ChatGPTDrawerResponse.fromJson(String source) => ChatGPTDrawerResponse.fromMap(json.decode(source));
}
