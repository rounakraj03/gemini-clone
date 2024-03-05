import 'package:client/network/models/chat_model.dart';
import 'package:client/network/models/drawer_request_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'claude_state.freezed.dart';

@freezed
class ClaudeState with _$ClaudeState {
  factory ClaudeState(
      {@Default([]) List<ClaudeChatModel> claudeChatModelList,
      @Default([]) List<ClaudeDrawerResponse> claudeDrawerData,
      @Default("") String emailId,
      String? claudeChatId,
      String? bookHeading}) = _ClaudeState;
}
