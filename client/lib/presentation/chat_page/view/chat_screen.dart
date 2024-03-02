import 'package:client/presentation/chat_page/state/chat_state.dart';
import 'package:client/routes/route_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:client/di/di.dart';
import 'package:client/network/repository/chat_repository.dart';
import 'package:client/network/models/chat_model.dart';
import 'package:client/network/models/drawer_request_response.dart';
import 'package:client/network/models/new_chat_request.dart';
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
  late ScrollController _scrollController;
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // Add a GlobalKey

  // List<GeminiChatModel> geminiChatModelList = [
  //   GeminiChatModel(role: 'user', parts: "Hi"),
  //   GeminiChatModel(role: 'model', parts: "Hi, How can I help you today"),
  // ];

  // List<ChatGPTChatModel> chatGPTChatModelList = [
  //   ChatGPTChatModel(role: 'user', content: "Hi"),
  //   ChatGPTChatModel(
  //       role: 'assistant', content: "Hi, How can I help you today"),
  // ];

  final textController = TextEditingController();

  final selectedImageSize = 40.0;
  final unselectedImageSize = 30.0;
  final selectedPaddingSize = 10.0;
  final unselectedPaddingSize = 5.0;

  // getGeminiChatResponse({required List<GeminiChatModel> messages}) async {
  //   try {
  //     var result = await chatRepository
  //         .getGeminiChatResponse(GeminiNewChatRequest(
  //             userId: "65dc4685d23b1f44f89babb1",
  //             chatId: geminiChatId,
  //             new_message: messages.last.parts,
  //             old_message: messages.sublist(0, messages.length - 1)))
  //         .listen((event) {
  //       geminiChatId = event.chatId;
  //       // if (event == "") {
  //       //   event.data = "\n\n";
  //       // } else {
  //       //   event.data += "\n";
  //       // }
  //       // print("event : $event");
  //       scrollToBottom();
  //       setState(() {
  //         if (geminiChatModelList.last.role == "user") {
  //           geminiChatModelList
  //               .add(GeminiChatModel(role: "model", parts: event.data));
  //         } else {
  //           geminiChatModelList.last.parts += event.data;
  //         }
  //       });
  //     });
  //   } catch (e) {
  //     print("Error: $e");
  //   }
  // }

  // getChatGPTChatResponse({required List<ChatGPTChatModel> messages}) async {
  //   try {
  //     var result = await chatRepository
  //         .getChatGPTChatResponse(ChatGPTNewChatRequest(
  //             new_message: "hi",
  //             old_message: messages,
  //             userId: "65dc4685d23b1f44f89babb1",
  //             chatId: chatGptChatId))
  //         .listen((event) {
  //       chatGptChatId = event.chatId;
  //       // if (event.data == "") {
  //       //   // event.data = "\n\n";
  //       //   event.data = "";
  //       // } else {
  //       //   // event.data += "\n";
  //       //   event.data += "";
  //       // }
  //       // print("event : $event");
  //       scrollToBottom();
  //       setState(() {
  //         if (chatGPTChatModelList.last.role == "user") {
  //           chatGPTChatModelList
  //               .add(ChatGPTChatModel(role: "assistant", content: event.data));
  //         } else {
  //           chatGPTChatModelList.last.content += event.data;
  //         }
  //       });
  //     });
  //   } catch (e) {
  //     print("Error: $e");
  //   }
  // }

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
    chatBloc.initialize();
    chatBloc.getDrawerData();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      scrollToBottom(); // Call scrollToBottom after the frame is rendered
    });
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
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
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
                                            Icons
                                                .power_settings_new_outlined,
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
                                print(
                                    "chatgptchatId=> ${state.chatGptChatId}");
                              } else {
                                chatBloc.updateGeminichatIdValue(null);
                                chatBloc.setDefaultGeminiChatModelList();
                                print(
                                    "geminichatId=> ${state.geminiChatId}");
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
                              ? Text(state
                                  .chatgptDrawerData[index - 1].heading)
                              : Text(state
                                  .geminiDrawerData[index - 1].heading),
                          onTap: () {
                            print(state.chatgptDrawerData[index - 1].id);
                            if (state.chatgptSelected) {
                              chatBloc.updateChatGPTchatIdValue(
                                  state.chatgptDrawerData[index - 1].id);
                              chatBloc.updateChatGPTmodelList(state
                                  .chatgptDrawerData[index - 1]
                                  .chatHistory);
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
              body: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      CustomAppBar(
                          customAppBarAttribute: CustomAppBarAttribute(
                              appBarSideWidgets: AppBarSideWidgets(
                        leading: Row(
                          children: [
                            InkWell(
                              onTapDown: (details) {
                                setState(() {
                                  chatBloc.updateChatGptSelected(true);
                                  print(
                                      "chatgptchatId=> ${state.chatGptChatId}");
                                });
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
                                        borderRadius:
                                            BorderRadius.circular(100)),
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
                                        borderRadius:
                                            BorderRadius.circular(100)),
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
                              print("Drawer");
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
                                      ? ListView.separated(
                                          controller: _scrollController,
                                          itemBuilder: (context, index) =>
                                              _chatGPTChatBubble(state
                                                  .chatGPTChatModelList[index]),
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(height: 20),
                                          itemCount:
                                              state.chatGPTChatModelList.length,
                                        )
                                      : ListView.separated(
                                          controller: _scrollController,
                                          itemBuilder: (context, index) =>
                                              _geminiChatBubble(state
                                                  .geminiChatModelList[index]),
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(height: 20),
                                          itemCount:
                                              state.geminiChatModelList.length,
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
                                            scrollToBottom();
                                            if (state.chatgptSelected) {
                                              List<ChatGPTChatModel> tempList =
                                                  List.of(state
                                                      .chatGPTChatModelList);
                                              tempList.add(ChatGPTChatModel(
                                                  role: 'user',
                                                  content: textController.text
                                                      .trim()));
                                              chatBloc.updateChatGPTmodelList(
                                                  tempList);

                                              textController.clear();
                                              FocusScope.of(context).unfocus();
                                              chatBloc.getChatGPTChatResponse(
                                                  messages: tempList);
                                            } else {
                                              List<GeminiChatModel> tempList =
                                                  List.of(state
                                                      .geminiChatModelList);
                                              tempList.add(GeminiChatModel(
                                                  role: 'user',
                                                  parts: textController.text
                                                      .trim()));
                                              chatBloc.updateGeminiModelList(
                                                  tempList);
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
                  );
                },
              ));
        },
      ),
    );
  }

  Widget _geminiChatBubble(GeminiChatModel chatModel) {
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

  Widget _chatGPTChatBubble(ChatGPTChatModel chatModel) {
    if (chatModel.role == 'assistant') {
      return Row(
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: Image.asset(
              Assets.chatGPTLogo2,
              fit: BoxFit.cover,
              color: AppColors.chatGPTColor,
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
                chatModel.content,
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
                chatModel.content,
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
