import 'package:client/network/models/chat_model.dart';
import 'package:client/network/models/drawer_request_response.dart';
import 'package:client/network/models/new_chat_request.dart';
import 'package:client/network/repository/chat_repository.dart';
import 'package:client/presentation/gemini_page/state/gemini_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GeminiBloc extends Cubit<GeminiState> {
  ChatRepository chatRepository;
  GeminiBloc(this.chatRepository) : super(GeminiState());
  final ScrollController scrollController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  initialize() {
    getEmailId();
    getDrawerData();
    setDefaultGeminiChatModelList();
    updateGeminichatIdValue(null);
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

  void setDefaultGeminiChatModelList() {
    List<GeminiChatModel> defaultGeminiChatModelList = [
      GeminiChatModel(role: 'user', parts: "Hi"),
      GeminiChatModel(role: 'model', parts: "Hi, How can I help you today"),
    ];
    emit(state.copyWith(geminiChatModelList: defaultGeminiChatModelList));
  }

  void updateGeminiModelList(List<GeminiChatModel> value) {
    emit(state.copyWith(geminiChatModelList: value));
  }

  updateGeminichatIdValue(String? value) {
    emit(state.copyWith(geminiChatId: value));
  }

  getDrawerData() async {
    try {
      String userId = await chatRepository.getUserId();
      if (userId == "") {
        //TODO LOGOUT
      } else {
        final geminiDrawerResult = await chatRepository
            .getGeminiDrawerData(DrawerRequest(userId: userId));
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
          } else {
            List<GeminiChatModel> tempList = List.of(state.geminiChatModelList);
            String tempLastParts = tempList.last.parts;
            tempLastParts = tempLastParts + event.data;
            List<GeminiChatModel> tempList2 =
                tempList.sublist(0, tempList.length - 1);
            tempList2.add(GeminiChatModel(role: "model", parts: tempLastParts));
            updateGeminiModelList(tempList2);
            scrollToBottom();
          }
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
