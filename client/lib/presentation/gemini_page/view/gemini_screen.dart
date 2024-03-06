import 'package:client/di/di.dart';
import 'package:client/network/models/chat_model.dart';
import 'package:client/presentation/gemini_page/bloc/gemini_bloc.dart';
import 'package:client/presentation/gemini_page/state/gemini_state.dart';
import 'package:client/res/app_colors.dart';
import 'package:client/res/assets.dart';
import 'package:client/res/custom_appBar.dart';
import 'package:client/res/custom_textfield_controller.dart';
import 'package:client/res/gemini_chat_bubble.dart';
import 'package:client/routes/route_data.dart';
import 'package:client/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final geminiBloc = getIt.get<GeminiBloc>();

class GeminiScreen extends StatefulWidget {
  const GeminiScreen({super.key});

  @override
  State<GeminiScreen> createState() => _GeminiScreenState();
}

class _GeminiScreenState extends State<GeminiScreen> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    geminiBloc.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: geminiBloc,
      child: Scaffold(
        key: geminiBloc.scaffoldKey,
        drawer: const GeminiDrawerWidget(),
        body: Column(children: [
          CustomChatAppBar(selectedIndex: 2),
          Expanded(child: BackCardOnTopView(
            child: BlocBuilder<GeminiBloc, GeminiState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Expanded(
                        child: ListView.separated(
                      controller: geminiBloc.scrollController,
                      itemBuilder: (context, index) => GeminiChatBubble(
                          chatModel: state.geminiChatModelList[index]),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20),
                      itemCount: state.geminiChatModelList.length,
                    )),
                    CustomTextField(
                      textController: textEditingController,
                      onTap: () {
                        if (textEditingController.text.isNotEmpty) {
                          setState(() {
                            geminiBloc.scrollToBottom();
                            List<GeminiChatModel> tempList =
                                List.of(state.geminiChatModelList);
                            tempList.add(GeminiChatModel(
                                role: 'user',
                                parts: textEditingController.text.trim()));
                            geminiBloc.updateGeminiModelList(tempList);
                            textEditingController.clear();
                            FocusScope.of(context).unfocus();
                            geminiBloc.getGeminiChatResponse(
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

class GeminiDrawerWidget extends StatelessWidget {
  const GeminiDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: geminiBloc,
      child: BlocBuilder<GeminiBloc, GeminiState>(
        builder: (context, state) {
          return Drawer(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: state.geminiDrawerData.length + 1,
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
                          geminiBloc.updateGeminichatIdValue(null);
                          geminiBloc.setDefaultGeminiChatModelList();
                          RouteData.pop();
                        },
                      )
                    ],
                  );
                } else {
                  return ListTile(
                      title: Text(state.geminiDrawerData[index - 1].heading),
                      onTap: () {
                        geminiBloc.updateGeminichatIdValue(
                            state.geminiDrawerData[index - 1].chatId);
                        geminiBloc.updateGeminiModelList(
                            state.geminiDrawerData[index - 1].chatHistory);
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

class GeminiAppBarWidget extends StatelessWidget {
  const GeminiAppBarWidget({super.key});

  final selectedImageSize = 40.0;
  final unselectedImageSize = 30.0;
  final selectedPaddingSize = 10.0;
  final unselectedPaddingSize = 5.0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: geminiBloc,
      child: BlocBuilder<GeminiBloc, GeminiState>(
        builder: (context, state) {
          return CustomAppBar(
              customAppBarAttribute: CustomAppBarAttribute(
                  appBarSideWidgets: AppBarSideWidgets(
            leading: Row(
              children: [
                InkWell(
                  onTapDown: (details) {
                    ChatgptRoute().push();
                    // chatBloc.updateChatGptSelected(true);
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
                  geminiBloc.getDrawerData();
                  geminiBloc.scaffoldKey.currentState?.openDrawer();
                },
              ),
            ),
          )));
        },
      ),
    );
  }
}
