import 'package:client/res/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final textController;
  VoidCallback? onTap;
  CustomTextField({required this.textController, this.onTap, super.key});

  @override
  State<CustomTextField> createState() => _CustomTextFieldRowState();
}

class _CustomTextFieldRowState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: widget.textController,
            maxLines: 6,
            minLines: 1,
            cursorColor: AppColors.scaffoldBgColor,
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
              if (widget.textController.text.isNotEmpty) {
                setState(() {
                  if (widget.onTap != null) {
                    widget.onTap!();
                  }
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
    );
  }
}
