import 'package:client/presentation/chat_page/view/chat_screen.dart';
import 'package:client/presentation/login_page/view/login_screen.dart';
import 'package:client/routes/route_data.dart';
import 'package:flutter/material.dart';

class LoginRoute extends RouteData {
  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }

  @override
  String get routeName => "/";
}

class ChatRoute extends RouteData {
  @override
  Widget build(BuildContext context) {
    return const ChatScreen();
  }

  @override
  String get routeName => "/chat";
}
