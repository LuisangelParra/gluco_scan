import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/common/widgets/success_screen/success_screen.dart';
import 'package:gluco_scan/data/repositories/authentication/authentication_repository.dart';
import 'package:gluco_scan/utils/popups/loaders.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  @override
  void onInit() {
    sendEmailVerification();
    setTimeForAutoRedirect();
    super.onInit();
  }

  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      LLoaders.successSnackBar(
        title: 'Email Sent',
        message: 'Please Check your inbox verify and verify your email',
      );
    } catch (e) {
      LLoaders.errorSnackBar(
        title: 'Oh Snap!',
        message: e.toString(),
      );
    }
  }

  setTimeForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() => SuccessScreen(
              image: LImages.successfullyRegisterAnimation,
              title: LTexts.yourAccountCreatedTitle,
              subTitle: LTexts.yourAccountCreatedSubTitle,
              onPressed: () =>
                  AuthenticationRepository.instance.screenRedirect(),
            ));
      }
    });
  }

  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => SuccessScreen(
            image: LImages.successfullyRegisterAnimation,
            title: LTexts.yourAccountCreatedTitle,
            subTitle: LTexts.yourAccountCreatedSubTitle,
            onPressed: () => AuthenticationRepository.instance.screenRedirect(),
          ));
    }
  }
}
