import 'package:client/network/chat_repository/chat_repository.dart';
import 'package:client/presentation/chat_page/chat_screen.dart';
import 'package:client/res/app_colors.dart';
import 'package:client/core/snack_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  ChatRepository chatRepository = ChatRepository();

  bool isLoginSelected = true;

  login(
      {required String email,
      required String password,
      required void Function(String userId) onSuccess,
      required bool isSignUp}) async {
    if (isSignUp) {
      final loginInfo =
          await chatRepository.signup(email: email, password: password);
      print("signUp userId =  ${loginInfo.id}");
      if (loginInfo.id != "") {
        chatRepository.saveUserId(loginInfo.id);
        onSuccess(loginInfo.id);
      }
    } else {
      final loginInfo =
          await chatRepository.login(email: email, password: password);
      print("login userId =  ${loginInfo.id}");
      if (loginInfo.id != "") {
        chatRepository.saveUserId(loginInfo.id);
        onSuccess(loginInfo.id);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoginSelected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffoldBgColor,
        body: Center(
          child: Container(
            width: double.maxFinite,
            margin: const EdgeInsets.all(25),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.desertStorm,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    isLoginSelected
                        ? "HI,\nWelcome back :)\n"
                        : "HI, \nLet's create a new account    ;)",
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  inputFormatters: [], //email validator
                  controller: emailController,
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      hintText: "Email",
                      fillColor: Colors.grey.shade300,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none)),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  autocorrect: false,
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      hintText: "Password",
                      fillColor: Colors.grey.shade300,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none)),
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (emailController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        scaffoldMessenger.showSnackBar(
                            text: isLoginSelected
                                ? "Logging in..."
                                : "Signing up...");
                      } else {
                        String email = emailController.text.trim();
                        email = email.toLowerCase();
                        String password = passwordController.text.trim();
                        setState(() {
                          emailController.clear();
                          passwordController.clear();
                          if (isLoginSelected) {
                            print("Login Clicked");
                            login(
                              isSignUp: false,
                              email: email,
                              password: password,
                              onSuccess: (userId) =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ChatScreen(),
                              )),
                            );
                          } else {
                            print("SignUp Clicked");
                            login(
                              isSignUp: true,
                              email: email,
                              password: password,
                              onSuccess: (userId) =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ChatScreen(),
                              )),
                            );
                          }
                        });
                      }
                    },
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20)),
                        backgroundColor: MaterialStateProperty.all(
                            AppColors.scaffoldBgColor)),
                    child: Row(
                      children: [
                        Text(
                          isLoginSelected ? "Login" : "Sign Up",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: isLoginSelected
                                ? "not a user?  "
                                : "Already a user?  ",
                            children: [
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      setState(() {
                                        if (isLoginSelected) {
                                          isLoginSelected = false;
                                          print("Moved to Sign Up");
                                        } else {
                                          isLoginSelected = true;
                                          print("Moved to Log In");
                                        }
                                      });
                                    },
                                  text: isLoginSelected ? "SIGN UP" : "LOGIN",
                                  style: const TextStyle(
                                      color: AppColors.scaffoldBgColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800))
                            ],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ))),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
