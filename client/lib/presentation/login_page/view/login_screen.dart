import 'package:client/di/di.dart';
import 'package:client/presentation/login_page/bloc/login_bloc.dart';
import 'package:client/presentation/login_page/state/login_state.dart';
import 'package:client/res/app_colors.dart';
import 'package:client/core/snack_bar.dart';
import 'package:client/routes/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final loginBloc = getIt.get<LoginBloc>();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: loginBloc,
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
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
                        state.isLoginSelected
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
                                text: state.isLoginSelected
                                    ? "All fields mandatory"
                                    : "All fields mandatory");
                          } else {
                            String email = emailController.text.trim();
                            email = email.toLowerCase();
                            String password = passwordController.text.trim();
                            setState(() {
                              emailController.clear();
                              passwordController.clear();
                              if (state.isLoginSelected) {
                                loginBloc.login(
                                  isSignUp: false,
                                  email: email,
                                  password: password,
                                  onSuccess: (userId) =>
                                      ClaudeRoute().pushReplacement(),
                                );
                              } else {
                                loginBloc.login(
                                    isSignUp: true,
                                    email: email,
                                    password: password,
                                    onSuccess: (userId) =>
                                        ClaudeRoute().pushReplacement());
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
                              state.isLoginSelected ? "Login" : "Sign Up",
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
                                text: state.isLoginSelected
                                    ? "not a user?  "
                                    : "Already a user?  ",
                                children: [
                                  TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          if (state.isLoginSelected) {
                                            loginBloc.updateLoginSelectedValue(
                                                false);
                                          } else {
                                            loginBloc
                                                .updateLoginSelectedValue(true);
                                          }
                                        },
                                      text: state.isLoginSelected
                                          ? "SIGN UP"
                                          : "LOGIN",
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
              )));
        },
      ),
    );
  }
}
