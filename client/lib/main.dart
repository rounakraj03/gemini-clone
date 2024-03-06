import 'package:client/core/app_loader.dart';
import 'package:client/di/di.dart';
import 'package:client/presentation/chatgpt_page/view/chatgpt_screen.dart';
import 'package:client/presentation/login_page/view/login_screen.dart';
import 'package:client/core/snack_bar.dart';
import 'package:client/res/app_colors.dart';
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
        builder: AppLoader.initBuilder(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: const ChatScreen(),
        home: FutureBuilder(
          future: loginBloc.isUserLoggedIn(),
          builder: (context, snapshot) {
            print("snapshot + $snapshot");
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == true) {
                return const ChatgptScreen();
              } else {
                return const LoginScreen();
              }
            } else {
              print("I am waiting");
              return Container(
                color: AppColors.desertStorm,
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.deepOrange),
                ),
              );
            }
          },
        ));
  }
}
