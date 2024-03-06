import 'package:client/presentation/chatgpt_page/bloc/chatgpt_bloc.dart';
import 'package:client/presentation/chatgpt_page/state/chatgpt_state.dart';
import 'package:client/presentation/chatgpt_page/view/chatgpt_screen.dart';
import 'package:client/presentation/claude_page/bloc/claude_bloc.dart';
import 'package:client/presentation/claude_page/state/claude_state.dart';
import 'package:client/presentation/claude_page/view/claude_screen.dart';
import 'package:client/presentation/gemini_page/bloc/gemini_bloc.dart';
import 'package:client/presentation/gemini_page/state/gemini_state.dart';
import 'package:client/presentation/gemini_page/view/gemini_screen.dart';
import 'package:client/res/app_colors.dart';
import 'package:client/res/assets.dart';
import 'package:client/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppBar extends StatelessWidget {
  final CustomAppBarAttribute customAppBarAttribute;
  const CustomAppBar({required this.customAppBarAttribute, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
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
            padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 10.0),
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

class CustomChatAppBar extends StatelessWidget {
  int selectedIndex;
  CustomChatAppBar({required this.selectedIndex, super.key});

  final selectedImageSize = 40.0;

  final unselectedImageSize = 30.0;

  final selectedPaddingSize = 10.0;

  final unselectedPaddingSize = 5.0;

  @override
  Widget build(BuildContext context) {
    if (selectedIndex == 1) {
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
                    onTapDown: (details) {},
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
                            Assets.chatGPTLogo2,
                            height: selectedImageSize,
                            width: selectedImageSize,
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
                      GeminiRoute().pushReplacement();
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
                            Assets.bardLogo,
                            height: unselectedImageSize,
                            width: unselectedImageSize,
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
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTapDown: (details) {
                      ClaudeRoute().pushReplacement();
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
                            Assets.claudeLogo2,
                            height: unselectedImageSize,
                            width: unselectedImageSize,
                            fit: BoxFit.cover,
                            color: AppColors.scaffoldBgColor,
                          ),
                        ),
                        const Text(
                          "Claude",
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
    if (selectedIndex == 2) {
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
                      ChatgptRoute().pushReplacement();
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
                    onTapDown: (details) {},
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
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTapDown: (details) {
                      ClaudeRoute().pushReplacement();
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
                            Assets.claudeLogo2,
                            height: unselectedImageSize,
                            width: unselectedImageSize,
                            fit: BoxFit.cover,
                            color: AppColors.scaffoldBgColor,
                          ),
                        ),
                        const Text(
                          "Claude",
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
    if (selectedIndex == 3) {
      return BlocProvider.value(
        value: claudeBloc,
        child: BlocBuilder<ClaudeBloc, ClaudeState>(
          builder: (context, state) {
            return CustomAppBar(
                customAppBarAttribute: CustomAppBarAttribute(
                    appBarSideWidgets: AppBarSideWidgets(
              leading: Row(
                children: [
                  InkWell(
                    onTapDown: (details) {
                      ChatgptRoute().pushReplacement();
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
                      GeminiRoute().pushReplacement();
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
                            Assets.bardLogo,
                            height: unselectedImageSize,
                            width: unselectedImageSize,
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
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTapDown: (details) {},
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
                            Assets.claudeLogo2,
                            height: selectedImageSize,
                            width: selectedImageSize,
                            fit: BoxFit.cover,
                            color: AppColors.scaffoldBgColor,
                          ),
                        ),
                        const Text(
                          "Claude",
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
                    claudeBloc.getDrawerData();
                    claudeBloc.scaffoldKey.currentState?.openDrawer();
                  },
                ),
              ),
            )));
          },
        ),
      );
    }
    return const SizedBox();
  }
}
