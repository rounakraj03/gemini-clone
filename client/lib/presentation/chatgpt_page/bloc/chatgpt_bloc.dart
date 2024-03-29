import 'package:client/core/app_loader.dart';
import 'package:client/network/models/chat_model.dart';
import 'package:client/network/models/drawer_request_response.dart';
import 'package:client/network/models/new_chat_request.dart';
import 'package:client/network/repository/chat_repository.dart';
import 'package:client/presentation/chatgpt_page/state/chatgpt_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ChatgptBloc extends Cubit<ChatgptState> {
  ChatRepository chatRepository;
  ChatgptBloc(this.chatRepository) : super(ChatgptState());
  final ScrollController scrollController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  initialize() {
    getEmailId();
    getDrawerData();
    setDefaultChatGptModelList();
    updateChatGPTchatIdValue(null);
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

  updateCanSendValue(bool value) {
    emit(state.copyWith(canSendMessage: value));
  }

  void setDefaultChatGptModelList() {
    List<ChatGPTChatModel> defaultChatGPTChatModelList = [
      ChatGPTChatModel(role: 'user', content: "Hi"),
      ChatGPTChatModel(
          role: 'assistant', content: "Hi, How can I help you today"),
    ];
    emit(state.copyWith(chatGPTChatModelList: defaultChatGPTChatModelList));
  }

  void updateChatGPTmodelList(List<ChatGPTChatModel> value) {
    emit(state.copyWith(chatGPTChatModelList: value));
  }

  getDrawerData() async {
    try {
      String userId = await chatRepository.getUserId();
      if (userId == "") {
        logOut();
      } else {
        final chatGptDrawerResult = await chatRepository
            .getChatGptDrawerData(DrawerRequest(userId: userId));
        chatGptDrawerResult.fold((l) => AppLoader.showError(l.errorMessage),
            (r) {
          emit(state.copyWith(chatgptDrawerData: r));
        });
      }
    } catch (e) {
      print("error: $e");
    }
  }

  updateChatGPTchatIdValue(String? value) {
    emit(state.copyWith(chatGptChatId: value));
  }

  getChatGPTChatResponse({required List<ChatGPTChatModel> messages}) async {
    try {
      String userId = await chatRepository.getUserId();
      if (userId == "") {
        logOut();
      } else {
        var result = await chatRepository
            .getChatGPTChatResponse(ChatGPTNewChatRequest(
                userId: userId,
                chatId: state.chatGptChatId,
                new_message: "hi",
                old_message: messages))
            .listen((event) {
          updateCanSendValue(false);
          print("e=> ${event.fold((l) => l.errorMessage, (r) => r)}");
          event.fold(
            (l) => AppLoader.showError(l.errorMessage),
            (r) {
              emit(state.copyWith(chatGptChatId: r.chatId));
              if (state.chatGPTChatModelList.last.role == "user") {
                List<ChatGPTChatModel> tempList =
                    List.of(state.chatGPTChatModelList);
                tempList
                    .add(ChatGPTChatModel(role: "assistant", content: r.data));
                updateChatGPTmodelList(tempList);
                scrollToBottom();
              } else {
                //
                List<ChatGPTChatModel> tempList =
                    List.of(state.chatGPTChatModelList);
                String tempLastParts = tempList.last.content;
                tempLastParts = tempLastParts + r.data;
                List<ChatGPTChatModel> tempList2 =
                    tempList.sublist(0, tempList.length - 1);
                tempList2.add(ChatGPTChatModel(
                    role: "assistant", content: tempLastParts));
                updateChatGPTmodelList(tempList2);
                scrollToBottom();
              }
            },
          );
        }, onDone: () {
          scrollToBottom();
          updateCanSendValue(true);
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
