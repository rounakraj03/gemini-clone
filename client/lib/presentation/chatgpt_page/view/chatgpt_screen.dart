import 'package:client/di/di.dart';
import 'package:client/network/models/chat_model.dart';
import 'package:client/presentation/chatgpt_page/bloc/chatgpt_bloc.dart';
import 'package:client/presentation/chatgpt_page/state/chatgpt_state.dart';
import 'package:client/res/app_colors.dart';
import 'package:client/res/assets.dart';
import 'package:client/res/chatGPT_chat_bubble.dart';
import 'package:client/res/custom_appBar.dart';
import 'package:client/res/custom_textfield_controller.dart';
import 'package:client/routes/route_data.dart';
import 'package:client/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final chatgptBloc = getIt.get<ChatgptBloc>();

class ChatgptScreen extends StatefulWidget {
  const ChatgptScreen({super.key});

  @override
  State<ChatgptScreen> createState() => _ChatgptScreenState();
}

class _ChatgptScreenState extends State<ChatgptScreen> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    chatgptBloc.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: chatgptBloc,
      child: Scaffold(
        key: chatgptBloc.scaffoldKey,
        drawer: const ChatgptDrawerWidget(),
        body: Column(children: [
          CustomChatAppBar(selectedIndex: 1),
          Expanded(child: BackCardOnTopView(
            child: BlocBuilder<ChatgptBloc, ChatgptState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Expanded(
                        child: ListView.separated(
                      controller: chatgptBloc.scrollController,
                      itemBuilder: (context, index) => ChatgptChatBubble(
                          chatModel: state.chatGPTChatModelList[index]),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20),
                      itemCount: state.chatGPTChatModelList.length,
                    )),
                    CustomTextField(
                      textController: textEditingController,
                      onTap: () {
                        if (textEditingController.text.isNotEmpty) {
                          setState(() {
                            chatgptBloc.scrollToBottom();
                            List<ChatGPTChatModel> tempList =
                                List.of(state.chatGPTChatModelList);
                            tempList.add(ChatGPTChatModel(
                                role: 'user',
                                content: textEditingController.text.trim()));
                            chatgptBloc.updateChatGPTmodelList(tempList);
                            textEditingController.clear();
                            FocusScope.of(context).unfocus();
                            chatgptBloc.getChatGPTChatResponse(
                                messages: tempList);
                          });
                        }
                      },
                    ),
                    const SizedBox(
                      height: 0,
                    )
                  ],
                );
              },
            ),
          ))
        ]),
      ),
    );
  }
}

class ChatgptDrawerWidget extends StatelessWidget {
  const ChatgptDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: chatgptBloc,
      child: BlocBuilder<ChatgptBloc, ChatgptState>(
        builder: (context, state) {
          return Drawer(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: state.chatgptDrawerData.length + 1,
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
                              Text(
                                state.emailId,
                                style: const TextStyle(
                                    color: AppColors.desertStorm, fontSize: 18),
                              )
                            ]),
                      ),
                      ListTile(
                        leading: const Icon(Icons.add_circle_outline),
                        title: const Text("New Chat"),
                        onTap: () {
                          chatgptBloc.updateChatGPTchatIdValue(null);
                          chatgptBloc.setDefaultChatGptModelList();
                          RouteData.pop();
                        },
                      )
                    ],
                  );
                } else {
                  return ListTile(
                      title: Text(state.chatgptDrawerData[index - 1].heading),
                      onTap: () {
                        chatgptBloc.updateChatGPTchatIdValue(
                            state.chatgptDrawerData[index - 1].chatId);
                        chatgptBloc.updateChatGPTmodelList(
                            state.chatgptDrawerData[index - 1].chatHistory);
                        RouteData.pop();
                      });
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class ChatgptAppBarWidget extends StatelessWidget {
  const ChatgptAppBarWidget({super.key});

  final selectedImageSize = 40.0;
  final unselectedImageSize = 30.0;
  final selectedPaddingSize = 10.0;
  final unselectedPaddingSize = 5.0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: chatgptBloc,
      child: BlocBuilder<ChatgptBloc, ChatgptState>(
        builder: (context, state) {
          return CustomAppBar(
              customAppBarAttribute: CustomAppBarAttribute(
                  appBarSideWidgets: AppBarSideWidgets(
            leading: Row(
              children: [
                InkWell(
                  onTapDown: (details) {
                    ChatgptRoute().push();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.all(
                          unselectedPaddingSize,
                        ),
                        decoration: BoxDecoration(
                            color: AppColors.desertStorm,
                            borderRadius: BorderRadius.circular(100)),
                        child: Image.asset(
                          Assets.chatGPTLogo2,
                          height: unselectedImageSize,
                          width: unselectedImageSize,
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
                    GeminiRoute().push();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.all(
                          selectedPaddingSize,
                        ),
                        decoration: BoxDecoration(
                            color: AppColors.desertStorm,
                            borderRadius: BorderRadius.circular(100)),
                        child: Image.asset(
                          Assets.bardLogo,
                          height: selectedImageSize,
                          width: selectedImageSize,
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
                  chatgptBloc.getDrawerData();
                  chatgptBloc.scaffoldKey.currentState?.openDrawer();
                },
              ),
            ),
          )));
        },
      ),
    );
  }
}
