import 'package:client/presentation/chat_page/state/chat_state.dart';
import 'package:client/res/chatGPT_chat_bubble.dart';
import 'package:client/res/gemini_chat_bubble.dart';
import 'package:client/routes/route_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:client/di/di.dart';
import 'package:client/network/models/chat_model.dart';
import 'package:client/presentation/chat_page/bloc/chat_bloc.dart';
import 'package:client/res/app_colors.dart';
import 'package:client/res/assets.dart';
import 'package:client/res/custom_appBar.dart';
import 'package:flutter/material.dart';

final chatBloc = getIt.get<ChatBloc>();

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // Add a GlobalKey

  final textController = TextEditingController();

  final selectedImageSize = 40.0;
  final unselectedImageSize = 30.0;
  final selectedPaddingSize = 10.0;
  final unselectedPaddingSize = 5.0;

 

  @override
  void initState() {
    super.initState();
    chatBloc.initialize();
    chatBloc.getDrawerData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: chatBloc,
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          return Scaffold(
              key: _scaffoldKey,
              drawer: Drawer(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: state.chatgptSelected
                      ? state.chatgptDrawerData.length + 1
                      : state.geminiDrawerData.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        children: [
                          DrawerHeader(
                            decoration: const BoxDecoration(
                              color: AppColors.scaffoldBgColor,
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 80,
                                        width: 80,
                                        child: Image.asset(Assets.benLogo),
                                      ),
                                      SizedBox(
                                        height: 80,
                                        width: 80,
                                        child: IconButton(
                                          icon: const Icon(
                                            size: 30,
                                            Icons.power_settings_new_outlined,
                                            color: AppColors.desertStorm,
                                          ),
                                          onPressed: () {
                                            print("LogOut");
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    "rounakraj@gmail.com",
                                    style: TextStyle(
                                        color: AppColors.desertStorm,
                                        fontSize: 18),
                                  )
                                ]),
                          ),
                          ListTile(
                            leading: const Icon(Icons.add_circle_outline),
                            title: const Text("New Chat"),
                            onTap: () {
                              if (state.chatgptSelected) {
                                chatBloc.updateChatGPTchatIdValue(null);
                                chatBloc.setDefaultChatGptModelList();
                                print("chatgptchatId=> ${state.chatGptChatId}");
                              } else {
                                chatBloc.updateGeminichatIdValue(null);
                                chatBloc.setDefaultGeminiChatModelList();
                                print("geminichatId=> ${state.geminiChatId}");
                              }
                              RouteData.pop();
                              // Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    } else {
                      return ListTile(
                          title: state.chatgptSelected
                              ? Text(state.chatgptDrawerData[index - 1].heading)
                              : Text(state.geminiDrawerData[index - 1].heading),
                          onTap: () {
                            print(state.chatgptDrawerData[index - 1].id);
                            if (state.chatgptSelected) {
                              chatBloc.updateChatGPTchatIdValue(
                                  state.chatgptDrawerData[index - 1].id);
                              chatBloc.updateChatGPTmodelList(state
                                  .chatgptDrawerData[index - 1].chatHistory);
                            } else {
                              chatBloc.updateGeminichatIdValue(
                                  state.geminiDrawerData[index - 1].id);
                              chatBloc.updateGeminiModelList(state
                                  .geminiDrawerData[index - 1].chatHistory);
                            }
                            RouteData.pop();
                            // Navigator.pop(context);
                          });
                    }
                  },
                ),
              ),
              body: Column(
                children: [
                  CustomAppBar(
                      customAppBarAttribute: CustomAppBarAttribute(
                          appBarSideWidgets: AppBarSideWidgets(
                    leading: Row(
                      children: [
                        InkWell(
                          onTapDown: (details) {
                            chatBloc.updateChatGptSelected(true);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.all(
                                  state.chatgptSelected
                                      ? selectedPaddingSize
                                      : unselectedPaddingSize,
                                ),
                                decoration: BoxDecoration(
                                    color: AppColors.desertStorm,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Image.asset(
                                  Assets.chatGPTLogo2,
                                  height: state.chatgptSelected
                                      ? selectedImageSize
                                      : unselectedImageSize,
                                  width: state.chatgptSelected
                                      ? selectedImageSize
                                      : unselectedImageSize,
                                  fit: BoxFit.cover,
                                  color: AppColors.scaffoldBgColor,
                                ),
                              ),
                              const Text(
                                "ChatGpt",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.desertStorm),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTapDown: (details) {
                            chatBloc.updateChatGptSelected(false);
                            print("geminichatId=> ${state.geminiChatId}");
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.all(
                                  state.chatgptSelected
                                      ? unselectedPaddingSize
                                      : selectedPaddingSize,
                                ),
                                decoration: BoxDecoration(
                                    color: AppColors.desertStorm,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Image.asset(
                                  Assets.bardLogo,
                                  height: state.chatgptSelected
                                      ? unselectedImageSize
                                      : selectedImageSize,
                                  width: state.chatgptSelected
                                      ? unselectedImageSize
                                      : selectedImageSize,
                                  fit: BoxFit.cover,
                                  color: AppColors.scaffoldBgColor,
                                ),
                              ),
                              const Text(
                                "Gemini",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.desertStorm),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    trailing: SizedBox(
                      width: 80,
                      child: IconButton(
                        icon: const Icon(
                          Icons.menu_rounded,
                          size: 35,
                          color: AppColors.desertStorm,
                        ),
                        onPressed: () {
                          chatBloc.getDrawerData();
                          _scaffoldKey.currentState?.openDrawer();
                        },
                      ),
                    ),
                  ))),
                  Expanded(
                    child: BackCardOnTopView(
                      child: Column(
                        children: [
                          Expanded(
                              child: (state.chatgptSelected)
                                  ? BlocBuilder<ChatBloc, ChatState>(
                                      builder: (context, state) {
                                        return ListView.separated(
                                          controller: chatBloc.scrollController,
                                          itemBuilder: (context, index) =>
                                              ChatGPTchatBubble(
                                                  chatModel: state
                                                          .chatGPTChatModelList[
                                                      index]),
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(height: 20),
                                          itemCount:
                                              state.chatGPTChatModelList.length,
                                        );
                                      },
                                    )
                                  : BlocBuilder<ChatBloc, ChatState>(
                                      builder: (context, state) {
                                        return ListView.separated(
                                          controller: chatBloc.scrollController,
                                          itemBuilder: (context, index) =>
                                              GeminiChatBubble(
                                                  chatModel:
                                                      state.geminiChatModelList[
                                                          index]),
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(height: 20),
                                          itemCount:
                                              state.geminiChatModelList.length,
                                        );
                                      },
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 12),
                                      hintText: "Ask Anything...",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                  onPressed: () {
                                    if (textController.text.isNotEmpty) {
                                      setState(() {
                                        chatBloc.scrollToBottom();
                                        if (state.chatgptSelected) {
                                          List<ChatGPTChatModel> tempList =
                                              List.of(
                                                  state.chatGPTChatModelList);
                                          tempList.add(ChatGPTChatModel(
                                              role: 'user',
                                              content:
                                                  textController.text.trim()));
                                          chatBloc
                                              .updateChatGPTmodelList(tempList);

                                          textController.clear();
                                          FocusScope.of(context).unfocus();
                                          chatBloc.getChatGPTChatResponse(
                                              messages: tempList);
                                        } else {
                                          List<GeminiChatModel> tempList =
                                              List.of(
                                                  state.geminiChatModelList);
                                          tempList.add(GeminiChatModel(
                                              role: 'user',
                                              parts:
                                                  textController.text.trim()));
                                          chatBloc
                                              .updateGeminiModelList(tempList);
                                          textController.clear();
                                          FocusScope.of(context).unfocus();
                                          chatBloc.getGeminiChatResponse(
                                              messages: tempList);
                                        }
                                      });
                                    }
                                  },
                                  icon: Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.scaffoldBgColor,
                                        borderRadius:
                                            BorderRadius.circular(30)),
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
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}
