import 'dart:async';
import 'dart:convert';
import 'package:client/core/secure_shared_preference.dart';
import 'package:client/network/models/claude_model.dart';
import 'package:client/network/models/drawer_request_response.dart';
import 'package:client/network/models/login_signUp_response_model.dart';
import 'package:client/network/models/login_signup_request_model.dart';
import 'package:client/network/models/new_chat_request.dart';
import 'package:client/network/models/new_chat_response.dart';
import 'package:client/network/network_response/network_error.dart';
import 'package:client/network/repository/chat_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChatRepository)
class ChatRepositoryImpl extends ChatRepository {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(minutes: 5), // Adjust as needed
      receiveTimeout: const Duration(minutes: 5), // Adjust as needed
    ),
  );
  ApiErrorHandler apiErrorHandler = ApiErrorHandler();
  SecuredSharedPreference securedSharedPreference = SecuredSharedPreference();
  // final baseUrl = "http://192.168.2.192:5001/";
  // final baseUrl = "http://192.168.29.234:8002/";
  final baseUrl = "http://35.154.226.55:8080/";

  final geminiNewChatUrl = "gemini/new-chat";
  final chatGPTNewChatUrl = "chatgpt/new-chat";
  final claudeNewChatUrl = "claude/new-chat";
  final claudeNextChatUrl = "claude/next-chats";

  final loginUrl = "user/login";
  final signupUrl = "user/signup";

  final geminiChatHistory = "gemini/getGeminiHistory";
  final chatGPTChatHistory = "chatgpt/getChatGptHistory";
  final claudeChatHistory = "claude/getClaudeHistory";

  ChatRepository() {
    print("Chat Repository Initialized");
  }

  @override
  Future<List<GeminiDrawerResponse>> getGeminiDrawerData(
      DrawerRequest drawerRequest) async {
    try {
      final apiUrl = baseUrl + geminiChatHistory;
      final response = await _dio.post(apiUrl, data: drawerRequest.toJson());
      List<GeminiDrawerResponse> result = [];
      response.data.forEach((e) => result.add(GeminiDrawerResponse.fromMap(e)));
      return result;
    } catch (e) {
      print("error : $e");
      apiErrorHandler.handleError(e);
      throw e;
    }
  }

  @override
  Future<List<ChatGPTDrawerResponse>> getChatGptDrawerData(
      DrawerRequest drawerRequest) async {
    try {
      final apiUrl = baseUrl + chatGPTChatHistory;
      final response = await _dio.post(apiUrl, data: drawerRequest.toJson());
      List<ChatGPTDrawerResponse> result = [];
      response.data
          .forEach((e) => result.add(ChatGPTDrawerResponse.fromMap(e)));

      return result;
    } catch (e) {
      print("error : $e");
      apiErrorHandler.handleError(e);
      throw e;
    }
  }

  @override
  Future<List<ClaudeDrawerResponse>> getClaudeDrawerData(
      DrawerRequest drawerRequest) async {
    try {
      final apiUrl = baseUrl + claudeChatHistory;
      final response = await _dio.post(apiUrl, data: drawerRequest.toJson());
      List<ClaudeDrawerResponse> result = [];
      response.data.forEach((e) => result.add(ClaudeDrawerResponse.fromMap(e)));
      return result;
    } catch (e) {
      print("error : $e");
      apiErrorHandler.handleError(e);
      throw e;
    }
  }

  @override
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
    } catch (e) {
      apiErrorHandler.handleError(e);
      print("error : $e");
    }
  }

  @override
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
    } catch (e) {
      apiErrorHandler.handleError(e);
      print("error : $e");
    }
  }

  @override
  Future<LoginSignUpResponse> login(
      {required String email, required String password}) async {
    try {
      final apiUrl = baseUrl + loginUrl;
      final response = await _dio.post(apiUrl,
          data: LoginSignUpRequest(email: email, password: password).toJson());
      final result = LoginSignUpResponse.fromMap(response.data);
      return result;
    } catch (e) {
      print("error: $e");
      apiErrorHandler.handleError(e);
      throw e;
    }
  }

  @override
  Future<LoginSignUpResponse> signup(
      {required String email, required String password}) async {
    try {
      final apiUrl = baseUrl + signupUrl;
      final response = await _dio.post(apiUrl,
          data: LoginSignUpRequest(email: email, password: password).toJson());
      print("response.data + ${response.data["status"]}");
      if (response.data["status"] == 400) {
        throw response.data["errorMessage"];
      }
      final result = LoginSignUpResponse.fromMap(response.data);
      return result;
    } catch (e) {
      print("error: $e");
      apiErrorHandler.handleError(e);
      throw e;
    }
  }

  @override
  Future<void> saveUserId(String value) async {
    await securedSharedPreference.secureSetString("userId", value);
  }

  @override
  Future<String> getUserId() async {
    final value = await securedSharedPreference.secureGetString("userId");
    return value;
  }

  @override
  Future<void> saveEmail(String value) async {
    await securedSharedPreference.secureSetString("email", value);
  }

  @override
  Future<String> getEmail() async {
    final value = await securedSharedPreference.secureGetString("email");
    return value;
  }

  @override
  Future<ClaudeNextChatResponse> getClaudeResponseWithFileUpload(
      FormData formData) async {
    final headers = <String, String>{
      'Content-Type': 'multipart/form-data',
    };
    final apiUrl = baseUrl + claudeNewChatUrl;
    final response = await _dio.post(
      apiUrl,
      data: formData,
      onSendProgress: (sent, total) {
        final progress = (sent / total) * 100;
        print('Upload progress: $progress%');
      },
      options: Options(headers: headers),
    );
    final result = ClaudeNextChatResponse.fromMap(response.data);
    return result;
  }

  @override
  Future<ClaudeNextChatResponse> getClaudeNextChatsResponse(
      ClaudeNextChatsRequest claudeNextChatsRequest) async {
    final apiUrl = baseUrl + claudeNextChatUrl;
    final response = await _dio.post(
      apiUrl,
      data: claudeNextChatsRequest.toJson(),
    );
    final result = ClaudeNextChatResponse.fromMap(response.data);
    return result;
  }

  @override
  Future<bool> getUserLogin() async {
    bool value = await securedSharedPreference.getBool("loginStatus");
    return value;
  }

  @override
  Future<void> saveUserLogin(bool value) async {
    await securedSharedPreference.setBool("loginStatus", value);
  }
}
