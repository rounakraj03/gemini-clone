import 'dart:io';

import 'package:client/core/snack_bar.dart';
import 'package:client/di/di.dart';
import 'package:client/network/models/chat_model.dart';
import 'package:client/presentation/claude_page/bloc/claude_bloc.dart';
import 'package:client/presentation/claude_page/state/claude_state.dart';
import 'package:client/res/app_colors.dart';
import 'package:client/res/assets.dart';
import 'package:client/res/claude_chat_bubble.dart';
import 'package:client/res/custom_appBar.dart';
import 'package:client/res/custom_textfield_controller.dart';
import 'package:client/routes/route_data.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final claudeBloc = getIt.get<ClaudeBloc>();

class ClaudeScreen extends StatefulWidget {
  const ClaudeScreen({super.key});

  @override
  State<ClaudeScreen> createState() => _ClaudeScreenState();
}

class _ClaudeScreenState extends State<ClaudeScreen> {
  String? fileName;
  String? filePath;
  bool isPdfUploaded = false;
  bool canUpload = true;
  File? file;
  PlatformFile? platformFile;

  TextEditingController textEditingController = TextEditingController();

  filePickerMethod() async {
    if (claudeBloc.state.claudeChatModelList.isEmpty) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null) {
        file = File(result.files.single.path!);
        platformFile = result.files.first;
        if (platformFile!.size / (1024 * 1024) > 10) {
          scaffoldMessenger.showSnackBar(
              text: "File Size Cannot be greater than 10MB");
          file = null;
        } else {
          claudeBloc.updateBookHeadingValue(platformFile!.name);
          setState(() {
            fileName = platformFile!.name;
            filePath = platformFile!.path;
            isPdfUploaded = true;
          });
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    claudeBloc.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: claudeBloc,
        child: Scaffold(
          key: claudeBloc.scaffoldKey,
          drawer: const ClaudeDrawerWidget(),
          body: Column(
            children: [
              CustomChatAppBar(selectedIndex: 3),
              Expanded(child: BackCardOnTopView(
                child: BlocBuilder<ClaudeBloc, ClaudeState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: ListView.separated(
                          controller: claudeBloc.scrollController,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              if (state.claudeChatModelList.isNotEmpty) {
                                return const SizedBox();
                              }
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Upload Pdf",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: InkWell(
                                        onTapDown: (details) {
                                          filePickerMethod();
                                        },
                                        child: DottedBorder(
                                          child: Container(
                                            padding: const EdgeInsets.all(20),
                                            child: const Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                      Icons.add_circle_outline),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    "Click to choose file",
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(Icons.info_outline,
                                                          size: 18),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        "Max file size: 10 MB",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 12),
                                                      )
                                                    ],
                                                  )
                                                ]),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            } else if (index == 1) {
                              if (state.bookHeading == "" ||
                                  state.bookHeading == null) {
                                return const SizedBox();
                              }
                              return Container(
                                margin:
                                    const EdgeInsets.all(20).copyWith(top: 10),
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black38)),
                                child: Row(children: [
                                  const Icon(
                                    Icons.file_present_outlined,
                                    color: Colors.redAccent,
                                    size: 30,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  if (state.bookHeading != null)
                                    Expanded(
                                        child: Text(
                                      state.bookHeading!,
                                    )),
                                ]),
                              );
                            }
                            return ClaudeChatBubble(
                                chatModel:
                                    state.claudeChatModelList[index - 2]);
                          },
                          itemCount: state.claudeChatModelList.length + 2,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                        )),
                        CustomTextField(
                            canSendMessage: state.canSendMessage,
                            textController: textEditingController,
                            onTap: () => setState(() {
                                  final claudeData = ClaudeChatModel(
                                      content: textEditingController.text,
                                      role: "Human");
                                  if (state.claudeChatModelList.isEmpty) {
                                    claudeBloc
                                        .updateClaudeModelList([claudeData]);
                                    claudeBloc.getClaudeReplyWithFile(
                                        fileName: fileName!,
                                        filePath: filePath!,
                                        question: textEditingController.text);
                                  } else {
                                    List<ClaudeChatModel> tempList =
                                        List.of(state.claudeChatModelList);
                                    tempList.add(claudeData);
                                    claudeBloc.updateClaudeModelList(tempList);
                                    claudeBloc.getClaudeNextChatReply(
                                        chatId: state.claudeChatId!,
                                        question: textEditingController.text);
                                  }
                                  textEditingController.clear();
                                  FocusScope.of(context).unfocus();
                                })),
                      ],
                    );
                  },
                ),
              ))
            ],
          ),
        ));
  }
}

class ClaudeDrawerWidget extends StatelessWidget {
  const ClaudeDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: claudeBloc,
      child: BlocBuilder<ClaudeBloc, ClaudeState>(
        builder: (context, state) {
          return Drawer(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: state.claudeDrawerData.length + 1,
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
                                        claudeBloc.logOut();
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
                          claudeBloc.updateCanSendValue(true);
                          claudeBloc.updateClaudechatIdValue(null);
                          claudeBloc.updateBookHeadingValue(null);
                          claudeBloc.setDefaultClaudeChatModelList();
                          RouteData.pop();
                        },
                      )
                    ],
                  );
                } else {
                  return ListTile(
                      title: Text(state.claudeDrawerData[index - 1].heading),
                      onTap: () {
                        claudeBloc.updateClaudechatIdValue(
                            state.claudeDrawerData[index - 1].chatId);
                        claudeBloc.updateBookHeadingValue(
                            state.claudeDrawerData[index - 1].heading);
                        claudeBloc.updateClaudeModelList(
                            state.claudeDrawerData[index - 1].chatHistory);
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
