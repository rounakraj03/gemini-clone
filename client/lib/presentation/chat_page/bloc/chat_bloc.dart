import 'package:bloc/bloc.dart';
import 'package:client/network/models/chat_model.dart';
import 'package:client/network/models/drawer_request_response.dart';
import 'package:client/network/models/new_chat_request.dart';
import 'package:client/network/repository/chat_repository.dart';
import 'package:client/presentation/chat_page/state/chat_state.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ChatBloc extends Cubit<ChatState> {
  ChatRepository chatRepository;
  ChatBloc(this.chatRepository) : super(ChatState());

  void setDefaultGeminiChatModelList() {
    List<GeminiChatModel> defaultGeminiChatModelList = [
      GeminiChatModel(role: 'user', parts: "Hi"),
      GeminiChatModel(role: 'model', parts: "Hi, How can I help you today"),
    ];
    emit(state.copyWith(geminiChatModelList: defaultGeminiChatModelList));
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
          emit(state.copyWith(geminiChatId: event.chatId));
          // scrollToBottom();
          if (state.geminiChatModelList.last.role == "user") {
            List<GeminiChatModel> tempList = List.of(state.geminiChatModelList);
            tempList.add(GeminiChatModel(role: "model", parts: event.data));
            emit(state.copyWith(geminiChatModelList: tempList));
          } else {
            List<GeminiChatModel> tempList = List.of(state.geminiChatModelList);
            tempList.last.parts += event.data;
            emit(state.copyWith(geminiChatModelList: tempList));
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
          emit(state.copyWith(chatGptChatId: event.chatId));
          // scrollToBottom();
          if (state.chatGPTChatModelList.last.role == "user") {
            List<ChatGPTChatModel> tempList =
                List.of(state.chatGPTChatModelList);
            tempList.add(ChatGPTChatModel(role: "model", content: event.data));
            emit(state.copyWith(chatGPTChatModelList: tempList));
          } else {
            List<ChatGPTChatModel> tempList =
                List.of(state.chatGPTChatModelList);
            tempList.last.content += event.data;
            emit(state.copyWith(chatGPTChatModelList: tempList));
          }
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
