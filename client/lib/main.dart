import 'package:client/presentation/chat_page/chat_screen.dart';
import 'package:client/presentation/login_page/login_page.dart';
import 'package:client/res/snack_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rounak AI',
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: scaffoldMessenger.scaffoldMessengerKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const ChatScreen(),
      home: LoginScreen(),
    );
  }
}
