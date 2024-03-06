import 'package:bloc/bloc.dart';
import 'package:client/network/models/chat_model.dart';
import 'package:client/network/models/drawer_request_response.dart';
import 'package:client/network/models/new_chat_request.dart';
import 'package:client/network/repository/chat_repository.dart';
import 'package:client/presentation/claude_page/state/claude_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ClaudeBloc extends Cubit<ClaudeState> {
  ChatRepository chatRepository;
  ClaudeBloc(this.chatRepository) : super(ClaudeState());
  final ScrollController scrollController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  initialize() {
    getEmailId();
    setDefaultClaudeChatModelList();
    updateClaudechatIdValue(null);
    getDrawerData();
  }

  logOut() async {
    await chatRepository.logOut();
  }

  getEmailId() async {
    String email = await chatRepository.getEmail();
    emit(state.copyWith(emailId: email));
  }

  void scrollToBottom({bool stopScrolling = false}) {
    if (!stopScrolling) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void setDefaultClaudeChatModelList() {
    List<ClaudeChatModel> defaultClaudeChatModelList = [];
    emit(state.copyWith(claudeChatModelList: defaultClaudeChatModelList));
  }

  void updateClaudeModelList(List<ClaudeChatModel> value) {
    emit(state.copyWith(claudeChatModelList: value));
  }

  updateClaudechatIdValue(String? value) {
    emit(state.copyWith(claudeChatId: value));
  }

  updateBookHeadingValue(String? value) {
    emit(state.copyWith(bookHeading: value));
  }

  getDrawerData() async {
    try {
      String userId = await chatRepository.getUserId();
      if (userId == "") {
        logOut();
      } else {
        final claudeDrawerResult = await chatRepository
            .getClaudeDrawerData(DrawerRequest(userId: userId));

        emit(state.copyWith(claudeDrawerData: claudeDrawerResult));
      }
    } catch (e) {
      print("error: $e");
    }
  }

  getClaudeReplyWithFile(
      {required String filePath,
      required String fileName,
      required String question}) async {
    String userId = await chatRepository.getUserId();
    if (userId == "") {
      logOut();
    } else {
      final formData = FormData.fromMap({
        'pdf': await MultipartFile.fromFile(filePath, filename: fileName),
        'question': question,
        'userId': userId
      });
      final response =
          await chatRepository.getClaudeResponseWithFileUpload(formData);
      updateClaudeModelList(response.chatHistory);
      updateClaudechatIdValue(response.chatId);
    }
  }

  getClaudeNextChatReply(
      {required String chatId, required String question}) async {
    String userId = await chatRepository.getUserId();
    if (userId == "") {
      logOut();
    } else {
      final response = await chatRepository.getClaudeNextChatsResponse(
          ClaudeNextChatsRequest(
              chatId: chatId, question: question, userId: userId));
      updateClaudeModelList(response.chatHistory);
      updateClaudechatIdValue(response.chatId);
      updateBookHeadingValue(response.heading);
    }
  }
}
