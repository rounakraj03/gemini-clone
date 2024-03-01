import 'dart:async';
import 'package:client/network/models/drawer_request_response.dart';
import 'package:client/network/models/login_signUp_response_model.dart';
import 'package:client/network/models/new_chat_request.dart';
import 'package:client/network/models/new_chat_response.dart';

abstract class ChatRepository {
  Future<List<GeminiDrawerResponse>> getGeminiDrawerData(
      DrawerRequest drawerRequest);

  Future<List<ChatGPTDrawerResponse>> getChatGptDrawerData(
      DrawerRequest drawerRequest);

  Stream<NewChatResponse> getGeminiChatResponse(
      GeminiNewChatRequest newChatRequest);

  Stream<NewChatResponse> getChatGPTChatResponse(
      ChatGPTNewChatRequest newChatRequest);

  Future<LoginSignUpResponse> login(
      {required String email, required String password});

  Future<LoginSignUpResponse> signup(
      {required String email, required String password});

  Future<void> saveUserId(String value);

  Future<String> getUserId();
}