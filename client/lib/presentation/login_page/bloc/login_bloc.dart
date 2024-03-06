import 'package:bloc/bloc.dart';
import 'package:client/network/repository/chat_repository.dart';
import 'package:client/presentation/login_page/state/login_state.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LoginBloc extends Cubit<LoginState> {
  ChatRepository chatRepository;
  LoginBloc(this.chatRepository) : super(LoginState());

  login(
      {required String email,
      required String password,
      required void Function(String userId) onSuccess,
      required bool isSignUp}) async {
    if (isSignUp) {
      final loginInfo =
          await chatRepository.signup(email: email, password: password);
      if (loginInfo.id != "") {
        chatRepository.saveUserId(loginInfo.id);
        chatRepository.saveEmail(email);
        chatRepository.saveUserLogin(true);
        onSuccess(loginInfo.id);
      }
    } else {
      final signUpInfo =
          await chatRepository.login(email: email, password: password);
      if (signUpInfo.id != "") {
        chatRepository.saveUserId(signUpInfo.id);
        chatRepository.saveEmail(email);
        chatRepository.saveUserLogin(true);
        onSuccess(signUpInfo.id);
      }
    }
  }

  updateLoginSelectedValue(bool value) {
    emit(state.copyWith(isLoginSelected: value));
  }

  Future<bool> isUserLoggedIn() async {
    bool value = await chatRepository.getUserLogin();
    return value;
  }
}
