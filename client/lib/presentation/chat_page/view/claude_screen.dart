import 'dart:io';

import 'package:client/core/snack_bar.dart';
import 'package:client/di/di.dart';
import 'package:client/network/models/chat_model.dart';
import 'package:client/presentation/chat_page/bloc/chat_bloc.dart';
import 'package:client/presentation/chat_page/state/chat_state.dart';
import 'package:client/presentation/chat_page/view/chat_screen.dart';
import 'package:client/res/app_colors.dart';
import 'package:client/res/claude_chat_bubble.dart';
import 'package:client/res/custom_appBar.dart';
import 'package:client/res/custom_textfield_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final chatBloc = getIt.get<ChatBloc>();

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
  // List<ClaudeChatModel> claudeChatModelList = [
  //   ClaudeChatModel(role: 'Human', parts: "Hi"),
  //   ClaudeChatModel(role: 'Assistant', parts: "Hi, How can I help you today"),
  // ];
  List<ClaudeChatModel> claudeChatModelList = [];

  TextEditingController textEditingController = TextEditingController();

  filePickerMethod() async {
    if (claudeChatModelList.length > 0) {
    } else {
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
          setState(() {
            fileName = platformFile!.name;
            filePath = platformFile!.path;
            isPdfUploaded = true;
          });
        }

        // print("file2.name" + platformFile!.name);
        // print("file2.bytes ${platformFile!.bytes}");
        // print("file2.size ${(platformFile!.size / 1024 * 1024)}");
        // print("file2.extension ${platformFile!.extension}");
        print("file2.path ${platformFile!.path}");
        print("file.path ${file!.path}");
      } else {
        // User canceled the picker
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: chatBloc,
        child: Scaffold(
          key: chatBloc.scaffoldKey,
          // drawer: const DrawerWidget(),
          body: Column(
            children: [
              const AppBarWidget(),
              Expanded(child: BackCardOnTopView(
                child: BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: ListView.separated(
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              if (!claudeChatModelList.isEmpty) {
                                return const SizedBox();
                              }
                              return const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: Text(
                                  "Upload Pdf",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            } else if (index == 1) {
                              if (!claudeChatModelList.isEmpty) {
                                return const SizedBox();
                              }
                              return Container(
                                margin:
                                    const EdgeInsets.all(20).copyWith(top: 10),
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
                                            Icon(Icons.add_circle_outline),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              "Click to choose file",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                              );
                            } else if (index == 2) {
                              if (fileName == null || fileName == "") {
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
                                  if (fileName != null)
                                    Expanded(
                                        child: Text(
                                      fileName!,
                                    )),
                                ]),
                              );
                            }
                            return ClaudeChatBubble(
                                chatModel: claudeChatModelList[index - 3]);
                          },
                          itemCount: claudeChatModelList.length + 3,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20),
                        )),
                        CustomTextField(
                            textController: textEditingController,
                            onTap: () => setState(() {
                                  print("abcde");
                                  chatBloc.getClaudeReplyWithFile(
                                      fileName: fileName!,
                                      filePath: filePath!,
                                      question: textEditingController.text);
                                  claudeChatModelList.add(ClaudeChatModel(
                                      role: "Human",
                                      parts: textEditingController.text));
                                  textEditingController.clear();
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
