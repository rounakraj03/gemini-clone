import 'package:client/res/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final CustomAppBarAttribute? customAppBarAttribute;
  const CustomAppBar({this.customAppBarAttribute, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.scaffoldBgColor,
      centerTitle: true,
      title: (customAppBarAttribute?.title != null)
          ? Text(
              customAppBarAttribute!.title!,
              style: const TextStyle(color: Colors.white),
            )
          : null,
      leading: customAppBarAttribute?.leading ?? const BackIcon(),
      actions: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: customAppBarAttribute?.trailing ?? const SizedBox(),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomAppBarAttribute {
  String? title;
  final Widget? trailing;
  final Widget? leading;

  CustomAppBarAttribute({this.title, this.trailing, this.leading});
}

Widget _card(Widget? bottomView, {EdgeInsets? padding}) {
  return Container(
    decoration: const BoxDecoration(
        color: AppColors.desertStorm,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30))),
    margin: EdgeInsets.zero,
    child: SizedBox(
      width: double.infinity,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(30.0),
        child: bottomView,
      ),
    ),
  );
}

class BackCardOnTopView extends StatelessWidget {
  final Widget child;
  final double onTopUiSpace;

  const BackCardOnTopView({
    required this.child,
    this.onTopUiSpace = 70.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.scaffoldBgColor,
      padding: EdgeInsets.only(top: onTopUiSpace),
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(child: _card(null)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 35.0, 15.0, 10.0),
            child: child,
          ),
        ],
      ),
    );
  }
}

class BackIcon extends StatelessWidget {
  final VoidCallback? onPressed;

  const BackIcon({this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        } else {
          Navigator.maybePop(context);
        }
      },
      icon: Navigator.canPop(context)
          ? const Icon(Icons.arrow_back_ios_new_outlined)
          : Container(),
    );
  }
}
