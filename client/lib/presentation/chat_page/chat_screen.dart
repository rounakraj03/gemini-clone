import 'package:client/network/chat_repository/chat_repository.dart';
import 'package:client/network/models/chat_model.dart';
import 'package:client/network/models/new_chat_request.dart';
import 'package:client/res/app_colors.dart';
import 'package:client/res/assets.dart';
import 'package:client/res/custom_appBar.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ScrollController _scrollController;

  List<ChatModel> chatModelList = [
    ChatModel(role: 'user', parts: "Hi"),
    ChatModel(role: 'model', parts: "Hi, How can I help you today"),
  ];
  final textController = TextEditingController();
  ChatRepository chatRepository = ChatRepository();

  getChatResponse({required List<ChatModel> messages}) async {
    try {
      var result = await chatRepository
          .getChatResponse(NewChatRequest(
              new_message: messages.last.parts,
              old_message: messages.sublist(0, messages.length - 1)))
          .listen((event) {
        if (event == "") {
          event = "\n\n";
        } else {
          event += "\n";
        }
        print("event : $event");
        scrollToBottom();
        setState(() {
          if (chatModelList.last.role == "user") {
            chatModelList.add(ChatModel(role: "model", parts: event));
          } else {
            chatModelList.last.parts += event;
          }
        });
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      scrollToBottom(); // Call scrollToBottom after the frame is rendered
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            customAppBarAttribute: CustomAppBarAttribute(title: "Gemini")),
        body: BackCardOnTopView(
          child: Column(
            children: [
              Expanded(
                  child: ListView.separated(
                controller: _scrollController,
                itemBuilder: (context, index) =>
                    _chatBubble(chatModelList[index]),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
                itemCount: chatModelList.length,
              )),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      maxLines: 6,
                      minLines: 1,
                      cursorColor: AppColors.scaffoldBgColor,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          hintText: "Ask Anything...",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: () {
                        if (textController.text.isNotEmpty) {
                          setState(() {
                            scrollToBottom();
                            chatModelList.add(ChatModel(
                                role: 'user', parts: textController.text));
                            textController.clear();
                            FocusScope.of(context).unfocus();
                            getChatResponse(messages: chatModelList);
                          });
                        }
                      },
                      icon: Container(
                        decoration: BoxDecoration(
                            color: AppColors.scaffoldBgColor,
                            borderRadius: BorderRadius.circular(30)),
                        height: 50,
                        width: 50,
                        child: const Icon(
                          Icons.send,
                          color: AppColors.desertStorm,
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: 0,
              )
            ],
          ),
        ));
  }

  Widget _chatBubble(ChatModel chatModel) {
    if (chatModel.role == 'model') {
      return Row(
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: Image.asset(
              Assets.bardLogo,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: AppColors.greyBgColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                chatModel.parts,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          )
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: AppColors.greyBgColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                chatModel.parts,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          SizedBox(
            height: 50,
            width: 50,
            child: Image.asset(
              Assets.benLogo,
              fit: BoxFit.cover,
            ),
          ),
        ],
      );
    }
  }
}
