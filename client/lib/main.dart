import 'package:client/di/di.dart';
import 'package:client/presentation/claude_page/view/claude_screen.dart';
import 'package:client/presentation/login_page/view/login_screen.dart';
import 'package:client/core/snack_bar.dart';
import 'package:client/routes/router.dart';
import 'package:flutter/material.dart';

void main() {
  configureDependencies();
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
      initialRoute: NavigationHandler.initialRoute,
      onGenerateRoute: NavigationHandler.onGenerate,
      navigatorKey: NavigationHandler.navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const ChatScreen(),
      home: const LoginScreen(),
      // home: const ClaudeScreen(),
    );
  }
}
