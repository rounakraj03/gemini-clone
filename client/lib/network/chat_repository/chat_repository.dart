import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:client/network/models/new_chat_request.dart';
import 'package:dio/dio.dart';

class ChatRepository {
  Dio _dio = Dio();
  // final baseUrl = "http://192.168.2.192:8002/";
  final baseUrl = "http://35.154.226.55:8080/";

  final geminiNewChatUrl = "chat/new-chat";
  final chatGPTNewChatUrl = "chatgpt/new-chat";

  ChatRepository() {
    print("Chat Repository Initialized");
  }

  Stream<String> getGeminiChatResponse(
      GeminiNewChatRequest newChatRequest) async* {
    try {
      final apiUrl = baseUrl + geminiNewChatUrl;
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

  Stream<String> getChatGPTChatResponse(
      ChatGPTNewChatRequest newChatRequest) async* {
    try {
      final apiUrl = baseUrl + chatGPTNewChatUrl;
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
