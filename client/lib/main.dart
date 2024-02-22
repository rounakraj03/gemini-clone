import 'dart:convert';

import 'package:client/network/chat_repository/chat_repository.dart';
import 'package:client/network/models/chat_model.dart';
import 'package:client/network/models/new_chat_request.dart';
import 'package:client/presentation/chat_page/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyHomePage(),
      home: const ChatScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Dio dio = Dio();
  ChatRepository chatRepository = ChatRepository();

  abc() async {
    var result = await chatRepository
        .getGeminiChatResponse(GeminiNewChatRequest(
            new_message:
                "Hi tell me the capital of india and 10 famous dishes here",
            old_message: [
          GeminiChatModel(role: 'user', parts: 'Hi I am rounak'),
          GeminiChatModel(
              role: 'model', parts: 'Hi Rounak, what can I do for you?')
        ]))
        .listen((event) {
      print("event + $event");
    });
  }

  @override
  void initState() {
    super.initState();
    // fetchUrl();
    print("Init state called");
    abc();
  }

  fetchUrl() async {
    print("Fetching URL");
    final result =
        await dio.post("http://192.168.2.192:8002/chat/new-chat", data: {
      "old_message": [
        {
          "role": "user",
          "parts":
              "Hello, I wanna get rich gemini but I need your help. Though it is great to meet you"
        },
        {
          "role": "model",
          "parts": "Great to meet you. What would you like to know?"
        }
      ],
      "new_message":
          "How can I get rich. What habits I need to have. How to control myself, my emotion and my mind."
    });
    print("result -> $result");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            abc();
          },
          child: Icon(Icons.abc)),
      body: Center(
        child: Text(
          "Hello World",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
