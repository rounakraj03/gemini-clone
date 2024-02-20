import 'dart:convert';
import 'package:client/network/models/chat_model.dart';

class NewChatRequest {
  String new_message;
  List<ChatModel> old_message;

  NewChatRequest({
    required this.new_message,
    required this.old_message,
  });

  Map<String, dynamic> toMap() {
    return {
      'new_message': new_message,
      'old_message': old_message.map((x) => x.toMap()).toList(),
    };
  }

  factory NewChatRequest.fromMap(Map<String, dynamic> map) {
    return NewChatRequest(
      new_message: map['new_message'] ?? '',
      old_message: List<ChatModel>.from(
          map['old_message']?.map((x) => ChatModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory NewChatRequest.fromJson(String source) =>
      NewChatRequest.fromMap(json.decode(source));
}
