import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:client/network/models/drawer_request_response.dart';
import 'package:client/network/models/new_chat_request.dart';
import 'package:client/network/models/new_chat_response.dart';
import 'package:dio/dio.dart';

class ChatRepository {
  Dio _dio = Dio();
  // final baseUrl = "http://192.168.2.192:5001/";
  // final baseUrl = "http://192.168.29.234:8002/";
  final baseUrl = "http://35.154.226.55:8080/";

  final geminiNewChatUrl = "gemini/new-chat";
  final chatGPTNewChatUrl = "chatgpt/new-chat";

  final geminiChatHistory = "gemini/getGeminiHistory";
  final chatGPTChatHistory = "chatgpt/getChatGptHistory";

  ChatRepository() {
    print("Chat Repository Initialized");
  }

  Future<List<GeminiDrawerResponse>> getGeminiDrawerData(
      DrawerRequest drawerRequest) async {
    try {
      final apiUrl = baseUrl + geminiChatHistory;
      final response = await _dio.post(apiUrl, data: drawerRequest.toJson());
      final List<dynamic> responseData = response.data;
      final List<GeminiDrawerResponse> result = responseData
          .map((data) => GeminiDrawerResponse.fromJson(data))
          .toList();
      return result;
    } catch (e) {
      print("error : $e");
      throw e;
    }
  }

  Future<List<ChatGPTDrawerResponse>> getChatGptDrawerData(
      DrawerRequest drawerRequest) async {
    try {
      final apiUrl = baseUrl + chatGPTChatHistory;
      final response = await _dio.post(apiUrl, data: drawerRequest.toJson());
      final List<dynamic> responseData = response.data;
      final List<ChatGPTDrawerResponse> result = responseData.map((e) => ChatGPTDrawerResponse.fromJson(jsonEncode(responseData))).toList();
      return result;
    } catch (e) {
      print("error : $e");
      throw e;
    }
  }

  Stream<NewChatResponse> getGeminiChatResponse(
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

      await for (final chunk in response.data.stream) {
        final jsonString = utf8.decode(chunk);
        final chatResponse = NewChatResponse.fromJson(jsonString);
        yield chatResponse;
      }

      // StreamTransformer<Uint8List, List<int>> uint8Transformer =
      //     StreamTransformer.fromHandlers(
      //   handleData: (data, sink) {
      //     sink.add(List<int>.from(data));
      //   },
      // );

      // response.data?.stream
      //     .transform(uint8Transformer)
      //     .transform(const Utf8Decoder())
      //     .transform(const LineSplitter())
      //     .listen((event) {
      //   try {
      //     controller.add(event);
      //   } catch (e) {
      //     print("Error: $e");
      //   }
      // });
      // await for (final value in controller.stream) {
      //   yield value;
      // }
    } catch (e) {
      print("error : $e");
    }
  }

  Stream<NewChatResponse> getChatGPTChatResponse(
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

      await for (final chunk in response.data.stream) {
        final jsonString = utf8.decode(chunk);
        // final chatResponse =
        //     ChatGPTNewChatResponse.fromJson(json.decode(jsonString));
        final chatResponse = NewChatResponse.fromJson(jsonString);
        yield chatResponse;
      }

      // StreamTransformer<Uint8List, List<int>> uint8Transformer =
      //     StreamTransformer.fromHandlers(
      //   handleData: (data, sink) {
      //     sink.add(List<int>.from(data));
      //   },
      // );

      // response.data?.stream
      //     .transform(uint8Transformer)
      //     .transform(const Utf8Decoder())
      //     .transform(const LineSplitter())
      //     .listen((event) {
      //   try {
      //     controller.add(event);
      //   } catch (e) {
      //     print("Error: $e");
      //   }
      // });
      // await for (final value in controller.stream) {
      //   yield value;
      // }
    } catch (e) {
      print("error : $e");
    }
  }
}
