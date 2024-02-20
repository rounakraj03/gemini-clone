import 'package:client/res/widgets/custom_appBar.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            customAppBarAttribute: CustomAppBarAttribute(title: "Gemini")),
        body: BackCardOnTopView(
          child: Column(
            children: [
              Expanded(
                  child: ListView(
                children: [
                  Text("abc"),
                  Text("abc"),
                  Text("abc"),
                  Text("abc"),
                  Text("abc"),
                ],
              )),
              TextField(),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ));
  }
}
