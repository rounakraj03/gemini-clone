import 'package:client/network/models/chat_model.dart';
import 'package:client/network/models/drawer_request_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'gemini_state.freezed.dart';

@freezed
class GeminiState with _$GeminiState {
  factory GeminiState(
      {@Default([]) List<GeminiDrawerResponse> geminiDrawerData,
      @Default([]) List<GeminiChatModel> geminiChatModelList,
      String? geminiChatId,
      @Default("") String emailId}) = _GeminiState;
}
