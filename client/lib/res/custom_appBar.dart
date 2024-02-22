import 'package:client/res/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final CustomAppBarAttribute customAppBarAttribute;
  const CustomAppBar({required this.customAppBarAttribute, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      color: AppColors.scaffoldBgColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                customAppBarAttribute.appBarSideWidgets.leading,
                const Spacer(),
                customAppBarAttribute.appBarSideWidgets.trailing
              ]),
        ),
      ),
    );
  }
}

class CustomSimpleAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final CustomAppBarAttribute? customAppBarAttribute;
  const CustomSimpleAppBar({required this.customAppBarAttribute, super.key});

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
      leading:
          customAppBarAttribute?.appBarSideWidgets?.leading ?? const BackIcon(),
      actions: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: customAppBarAttribute?.appBarSideWidgets?.trailing ??
              const SizedBox(),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AppBarSideWidgets {
  Widget trailing;
  Widget leading;

  AppBarSideWidgets({required this.trailing, required this.leading});
}

class CustomAppBarAttribute {
  String? title;
  String? image;
  AppBarSideWidgets appBarSideWidgets;

  CustomAppBarAttribute(
      {this.title, this.image, required this.appBarSideWidgets});
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
    this.onTopUiSpace = 30.0,
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
