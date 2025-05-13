import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/data/repositories/authentication/authentication_repository.dart';
import 'package:gluco_scan/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:gluco_scan/utils/helpers/network_manager.dart';
import 'package:gluco_scan/utils/popups/full_screen_loader.dart';
import 'package:gluco_scan/utils/popups/loaders.dart';

import '../../../../utils/constants/image_strings.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  sendPasswordResetEmail() async {
    try {
      LFullScreenLoader.openLoadingDialog(
          'Procesando tu solicitud...', LImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        LFullScreenLoader.stopLoading();
        return;
      }

      if (!forgetPasswordFormKey.currentState!.validate()) {
        LFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      LFullScreenLoader.stopLoading();

      LLoaders.successSnackBar(
          title: 'Correo enviado',
          message: 'Enlace de reinicio de contraseña enviado a su correo'.tr);

      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      LFullScreenLoader.stopLoading();
      LLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      LFullScreenLoader.openLoadingDialog(
          'Procesando tu solicitud...', LImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        LFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      LFullScreenLoader.stopLoading();

      LLoaders.successSnackBar(
          title: 'Correo enviado',
          message: 'Enlace de reinicio de contraseña enviado a su correo'.tr);
    } catch (e) {
      LFullScreenLoader.stopLoading();
      LLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
