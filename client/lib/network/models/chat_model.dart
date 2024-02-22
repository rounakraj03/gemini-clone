import 'dart:convert';

class GeminiChatModel {
  String role;
  String parts;
  GeminiChatModel({
    required this.role,
    required this.parts,
  });

  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'parts': parts,
    };
  }

  factory GeminiChatModel.fromMap(Map<String, dynamic> map) {
    return GeminiChatModel(
      role: map['role'] ?? '',
      parts: map['parts'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory GeminiChatModel.fromJson(String source) =>
      GeminiChatModel.fromMap(json.decode(source));
}

class ChatGPTChatModel {
  String role;
  String content;

  ChatGPTChatModel({
    required this.role,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'content': content,
    };
  }

  factory ChatGPTChatModel.fromMap(Map<String, dynamic> map) {
    return ChatGPTChatModel(
      role: map['role'] ?? '',
      content: map['content'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatGPTChatModel.fromJson(String source) =>
      ChatGPTChatModel.fromMap(json.decode(source));
}
