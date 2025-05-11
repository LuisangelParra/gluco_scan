import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gluco_scan/data/repositories/authentication/authentication_repository.dart';
import 'package:gluco_scan/features/personalization/controllers/user_controller.dart';
import 'package:gluco_scan/utils/helpers/network_manager.dart';
import 'package:gluco_scan/utils/popups/full_screen_loader.dart';
import 'package:gluco_scan/utils/popups/loaders.dart';

import '../../../../utils/constants/image_strings.dart';

class LoginController extends GetxController {
  /// Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  void onInit() {
    if (localStorage.read('REMEMBER_ME_EMAIL') != null &&
        localStorage.read('REMEMBER_ME_PASSWORD') != null) {
      email.text = localStorage.read('REMEMBER_ME_EMAIL');
      password.text = localStorage.read('REMEMBER_ME_PASSWORD');
    }
    super.onInit();
  }

  Future<void> emailAndPasswordSignIn() async {
    try {
      LFullScreenLoader.openLoadingDialog(
          'Logging you in...', LImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        LFullScreenLoader.stopLoading();
        return;
      }

      if (!loginFormKey.currentState!.validate()) {
        LFullScreenLoader.stopLoading();
        return;
      }

      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // ignore: unused_local_variable
      final userCredentials = await AuthenticationRepository.instance
          .loginUserWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      LFullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      LFullScreenLoader.stopLoading();
      LLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<void> googleSignIn() async {
    try {
      LFullScreenLoader.openLoadingDialog(
          'Logging you in...', LImages.docerAnimation);
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        LFullScreenLoader.stopLoading();
        return;
      }

      final userCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();

      await userController.saveUserRecord(userCredentials);

      LFullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      LFullScreenLoader.stopLoading();
      LLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
