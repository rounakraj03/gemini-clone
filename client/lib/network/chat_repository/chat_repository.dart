import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:client/network/models/new_chat_request.dart';
import 'package:dio/dio.dart';

class ChatRepository {
  Dio _dio = Dio();
  final baseUrl = "http://192.168.2.192:8002/";

  final newChat = "chat/new-chat";

  ChatRepository() {
    print("Chat Repository Initialized");
  }

  Stream<String> getChatResponse(NewChatRequest newChatRequest) async* {
    try {
      final apiUrl = baseUrl + newChat;
      print("get chat Api called $apiUrl");
      final controller = StreamController<String>();

      final response = await _dio.post(apiUrl,
          data: newChatRequest.toJson(),
          options: Options(headers: {
            'Accept': 'text/event-stream',
            "Cache-Control": "no-cache",
            "Content-Type": "application/json"
          }, responseType: ResponseType.stream));

      StreamTransformer<Uint8List, List<int>> uint8Transformer =
          StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          sink.add(List<int>.from(data));
        },
      );

      response.data?.stream
          .transform(uint8Transformer)
          .transform(const Utf8Decoder())
          .transform(const LineSplitter())
          .listen((event) {
        try {
          controller.add(event);
        } catch (e) {
          print("Error: $e");
        }
      });
      await for (final value in controller.stream) {
        yield value;
      }
    } catch (e) {
      print("error : $e");
    }
  }
}
