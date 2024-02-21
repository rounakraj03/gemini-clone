import 'package:client/network/models/chat_model.dart';
import 'package:client/res/app_colors.dart';
import 'package:client/res/assets.dart';
import 'package:flutter/material.dart';

class GeminiChatBubble extends StatefulWidget {
  final List<ChatModel> chatModelList;
  const GeminiChatBubble({required this.chatModelList, super.key});

  @override
  State<GeminiChatBubble> createState() => _GeminiChatBubbleState();
}

class _GeminiChatBubbleState extends State<GeminiChatBubble> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => _chatBubble(widget.chatModelList[index]),
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemCount: widget.chatModelList.length,
    );
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
