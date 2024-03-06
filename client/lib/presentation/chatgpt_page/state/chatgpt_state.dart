import 'package:client/network/models/chat_model.dart';
import 'package:client/network/models/drawer_request_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chatgpt_state.freezed.dart';

@freezed
class ChatgptState with _$ChatgptState {
  factory ChatgptState(
      {@Default([]) List<ChatGPTDrawerResponse> chatgptDrawerData,
      @Default([]) List<ChatGPTChatModel> chatGPTChatModelList,
      String? chatGptChatId,
      @Default("") String emailId,
      @Default(true) bool canSendMessage}) = _ChatgptState;
}
