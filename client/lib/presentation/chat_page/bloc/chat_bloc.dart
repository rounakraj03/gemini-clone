import 'package:bloc/bloc.dart';
import 'package:client/network/models/chat_model.dart';
import 'package:client/network/models/drawer_request_response.dart';
import 'package:client/network/models/new_chat_request.dart';
import 'package:client/network/repository/chat_repository.dart';
import 'package:client/presentation/chat_page/state/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ChatBloc extends Cubit<ChatState> {
  ChatRepository chatRepository;
  ChatBloc(this.chatRepository) : super(ChatState());
  final ScrollController scrollController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  initialize() {
    setDefaultGeminiChatModelList();
    setDefaultChatGptModelList();
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

  void setDefaultGeminiChatModelList() {
    List<GeminiChatModel> defaultGeminiChatModelList = [
      GeminiChatModel(role: 'user', parts: "Hi"),
      GeminiChatModel(role: 'model', parts: "Hi, How can I help you today"),
    ];
    emit(state.copyWith(geminiChatModelList: defaultGeminiChatModelList));
  }

  void updateChatGPTmodelList(List<ChatGPTChatModel> value) {
    emit(state.copyWith(chatGPTChatModelList: value));
  }

  void updateGeminiModelList(List<GeminiChatModel> value) {
    emit(state.copyWith(geminiChatModelList: value));
  }

  void updateChatGptSelected(bool value) {
    emit(state.copyWith(chatgptSelected: value));
  }

  void setDefaultChatGptModelList() {
    List<ChatGPTChatModel> defaultChatGPTChatModelList = [
      ChatGPTChatModel(role: 'user', content: "Hi"),
      ChatGPTChatModel(
          role: 'assistant', content: "Hi, How can I help you today"),
    ];
    emit(state.copyWith(chatGPTChatModelList: defaultChatGPTChatModelList));
  }

  getDrawerData() async {
    try {
      String userId = await chatRepository.getUserId();
      if (userId == "") {
        //TODO LOGOUT
      } else {
        final chatGptDrawerResult = await chatRepository
            .getChatGptDrawerData(DrawerRequest(userId: userId));
        final geminiDrawerResult = await chatRepository
            .getGeminiDrawerData(DrawerRequest(userId: userId));
        emit(state.copyWith(chatgptDrawerData: chatGptDrawerResult));
        emit(state.copyWith(geminiDrawerData: geminiDrawerResult));
      }
    } catch (e) {
      print("error: $e");
    }
  }

  getGeminiChatResponse({required List<GeminiChatModel> messages}) async {
    try {
      String userId = await chatRepository.getUserId();
      if (userId == "") {
        //TODO LOGOUT
      } else {
        var result = await chatRepository
            .getGeminiChatResponse(GeminiNewChatRequest(
                userId: userId,
                chatId: state.geminiChatId,
                new_message: messages.last.parts,
                old_message: messages.sublist(0, messages.length - 1)))
            .listen((event) {
          print("e=> ${event.data}");
          emit(state.copyWith(geminiChatId: event.chatId));
          if (state.geminiChatModelList.last.role == "user") {
            List<GeminiChatModel> tempList = List.of(state.geminiChatModelList);
            tempList.add(GeminiChatModel(role: "model", parts: event.data));
            updateGeminiModelList(tempList);
            scrollToBottom();
            // emit(state.copyWith(geminiChatModelList: tempList));
          } else {
            List<GeminiChatModel> tempList = List.of(state.geminiChatModelList);
            String tempLastParts = tempList.last.parts;
            tempLastParts = tempLastParts + event.data;
            List<GeminiChatModel> tempList2 =
                tempList.sublist(0, tempList.length - 1);
            tempList2.add(GeminiChatModel(role: "model", parts: tempLastParts));
            updateGeminiModelList(tempList2);
            scrollToBottom();
            // emit(state.copyWith(geminiChatModelList: tempList));
          }
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  getChatGPTChatResponse({required List<ChatGPTChatModel> messages}) async {
    try {
      String userId = await chatRepository.getUserId();
      if (userId == "") {
        //TODO LOGOUT
      } else {
        var result = await chatRepository
            .getChatGPTChatResponse(ChatGPTNewChatRequest(
                userId: userId,
                chatId: state.chatGptChatId,
                new_message: "hi",
                old_message: messages))
            .listen((event) {
          print("e=> ${event.data}");
          emit(state.copyWith(chatGptChatId: event.chatId));
          if (state.chatGPTChatModelList.last.role == "user") {
            List<ChatGPTChatModel> tempList =
                List.of(state.chatGPTChatModelList);
            tempList
                .add(ChatGPTChatModel(role: "assistant", content: event.data));
            updateChatGPTmodelList(tempList);
            scrollToBottom();
          } else {
            //
            List<ChatGPTChatModel> tempList =
                List.of(state.chatGPTChatModelList);
            String tempLastParts = tempList.last.content;
            tempLastParts = tempLastParts + event.data;
            List<ChatGPTChatModel> tempList2 =
                tempList.sublist(0, tempList.length - 1);
            tempList2.add(
                ChatGPTChatModel(role: "assistant", content: tempLastParts));
            updateChatGPTmodelList(tempList2);
            scrollToBottom();
          }
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  updateChatGPTchatIdValue(String? value) {
    emit(state.copyWith(chatGptChatId: value));
  }

  updateGeminichatIdValue(String? value) {
    emit(state.copyWith(geminiChatId: value));
  }
}
