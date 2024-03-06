import 'dart:async';
import 'package:client/network/models/claude_model.dart';
import 'package:client/network/models/drawer_request_response.dart';
import 'package:client/network/models/login_signUp_response_model.dart';
import 'package:client/network/models/new_chat_request.dart';
import 'package:client/network/models/new_chat_response.dart';
import 'package:client/network/network_response/network_error.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class ChatRepository {
  Future<Either<ErrorResponse, List<GeminiDrawerResponse>>> getGeminiDrawerData(
      DrawerRequest drawerRequest);

  Future<Either<ErrorResponse, List<ChatGPTDrawerResponse>>>
      getChatGptDrawerData(DrawerRequest drawerRequest);

  Future<Either<ErrorResponse, List<ClaudeDrawerResponse>>> getClaudeDrawerData(
      DrawerRequest drawerRequest);

  Stream<Either<ErrorResponse, NewChatResponse>> getGeminiChatResponse(
      GeminiNewChatRequest newChatRequest);

  Stream<Either<ErrorResponse, NewChatResponse>> getChatGPTChatResponse(
      ChatGPTNewChatRequest newChatRequest);

  Future<Either<ErrorResponse, LoginSignUpResponse>> login(
      {required String email, required String password});

  Future<Either<ErrorResponse, LoginSignUpResponse>> signup(
      {required String email, required String password});

  Future<void> saveUserId(String value);

  Future<String> getUserId();

  Future<void> saveEmail(String value);

  Future<String> getEmail();

  Future<bool> getUserLogin();

  Future<void> saveUserLogin(bool value);

  Future<void> logOut();

  Future<Either<ErrorResponse, ClaudeNextChatResponse>>
      getClaudeResponseWithFileUpload(FormData formData);

  Future<Either<ErrorResponse, ClaudeNextChatResponse>>
      getClaudeNextChatsResponse(ClaudeNextChatsRequest claudeNextChatsRequest);
}
