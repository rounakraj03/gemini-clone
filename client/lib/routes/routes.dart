import 'package:client/presentation/chatgpt_page/view/chatgpt_screen.dart';
import 'package:client/presentation/claude_page/view/claude_screen.dart';
import 'package:client/presentation/gemini_page/view/gemini_screen.dart';
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

class ClaudeRoute extends RouteData {
  @override
  Widget build(BuildContext context) {
    return const ClaudeScreen();
  }

  @override
  String get routeName => "/claude";
}

class ChatgptRoute extends RouteData {
  @override
  Widget build(BuildContext context) {
    return const ChatgptScreen();
  }

  @override
  String get routeName => "/chatgpt";
}

class GeminiRoute extends RouteData {
  @override
  Widget build(BuildContext context) {
    return const GeminiScreen();
  }

  @override
  String get routeName => "/gemini";
}
