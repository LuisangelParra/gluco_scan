// lib/common/widgets/loaders/full_screen_loader.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/common/widgets/loaders/animation_loader.dart';
import 'package:gluco_scan/utils/constants/colors.dart';
import 'package:gluco_scan/utils/helpers/helper_functions.dart';

class LFullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    // Usamos Get.dialog en lugar de showDialog
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: Material(
          color: THelperFunctions.isDarkMode(Get.context!)
              ? LColors.darkBackground
              : LColors.lightBackground,
          child: Center(
            child: TAnimationLoaderWidget(
              text: text,
              animation: animation,
            ),
          ),
        ),
      ),
      barrierDismissible: false,
      useSafeArea: true,
    );
  }

  static void stopLoading() {
    // Sólo cierra si hay diálogo abierto
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
}
