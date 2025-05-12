// lib/common/widgets/loaders/full_screen_loader.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/common/widgets/loaders/animation_loader.dart';
import 'package:gluco_scan/utils/constants/colors.dart';
import 'package:gluco_scan/utils/helpers/helper_functions.dart';

class LFullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        // evita que el back button cierre el diálogo
        onWillPop: () async => false,
        child: Material(
          // Material para heredar tema y gestos
          color: THelperFunctions.isDarkMode(Get.context!)
              ? LColors.darkBackground
              : LColors.lightBackground,
          child: Center(
            // todo centrado sin overflow
            child: TAnimationLoaderWidget(
              text: text,
              animation: animation,
            ),
          ),
        ),
      ),
    );
  }

  static void stopLoading() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
}
