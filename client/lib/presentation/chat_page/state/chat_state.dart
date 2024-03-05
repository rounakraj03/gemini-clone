import 'package:client/network/models/chat_model.dart';
import 'package:client/network/models/drawer_request_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_state.freezed.dart';

@freezed
class ChatState with _$ChatState {
  factory ChatState({
    @Default([]) List<ChatGPTDrawerResponse> chatgptDrawerData,
    @Default([]) List<GeminiDrawerResponse> geminiDrawerData,
    @Default([]) List<GeminiChatModel> geminiChatModelList,
    @Default([]) List<ChatGPTChatModel> chatGPTChatModelList,
    @Default([]) List<ClaudeChatModel> claudeChatModelList,
    @Default(false) bool chatgptSelected,
    String? chatGptChatId,
    String? geminiChatId,
    String? claudeChatId,
    String? bookHeading
  }) = _ChatState;
}
