import 'package:client/network/models/chat_model.dart';
import 'package:client/res/app_colors.dart';
import 'package:client/res/assets.dart';
import 'package:flutter/material.dart';

class ClaudeChatBubble extends StatelessWidget {
  final ClaudeChatModel chatModel;
  const ClaudeChatBubble({required this.chatModel, super.key});

  @override
  Widget build(BuildContext context) {
    if (chatModel.role == 'Assistant') {
      return Row(
        children: [
          ClipOval(
            child: SizedBox(
              height: 50,
              width: 50,
              child: Image.asset(
                Assets.claudeLogo,
                fit: BoxFit.cover,
                // color: AppColors.chatGPTColor,
              ),
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
              child: SelectableText(
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
              child: SelectableText(
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
