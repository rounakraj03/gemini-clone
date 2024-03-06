import 'package:client/res/app_colors.dart';
import 'package:client/res/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppLoader {
  static TransitionBuilder initBuilder({TransitionBuilder? builder}) {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.light
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..maskColor = AppColors.scaffoldBgColor
      ..userInteractions = true
      ..errorWidget =
          SizedBox(height: 100, width: 100, child: Image.asset(Assets.error))
      ..dismissOnTap = false;
    return EasyLoading.init(builder: builder);
  }

  static Future<void> showLoader({String? status}) {
    return EasyLoading.show(
        status: status ?? "Loading...", maskType: EasyLoadingMaskType.clear);
  }

  static Future<void> showUploadStatus(
      {required double value, String? status}) {
    return EasyLoading.showProgress(value,
        status: status, maskType: EasyLoadingMaskType.clear);
  }

  static Widget loader() {
    return LoadingAnimationWidget.inkDrop(
      color: const Color.fromARGB(255, 209, 22, 22),
      size: 200,
    );
  }

  static Future<void> dismissLoader() {
    return EasyLoading.dismiss(animation: true);
  }

  static void showToast(String? status,
      {EasyLoadingToastPosition? toastPosition}) async {
    if (status == null) {
      return;
    }
    await EasyLoading.showToast(status,
        toastPosition: toastPosition ?? EasyLoadingToastPosition.bottom);
  }

  static Future<void> showError(String error) {
    return EasyLoading.showError(error, duration: const Duration(seconds: 3));
  }
}
