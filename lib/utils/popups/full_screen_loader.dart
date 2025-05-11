import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/common/widgets/loaders/animation_loader.dart';
import 'package:gluco_scan/utils/helpers/helper_functions.dart';

import '../constants/colors.dart';

class LFullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: THelperFunctions.isDarkMode(Get.context!)
              ? LColors.darkBackground
              : LColors.lightBackground,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 250),
              TAnimationLoaderWidget(
                text: text,
                animation: animation,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
