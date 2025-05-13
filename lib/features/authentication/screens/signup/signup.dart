import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/common/widgets/buttons/primary_button.dart';
import 'package:gluco_scan/features/authentication/controllers/signup/signup_controller.dart';
import 'package:gluco_scan/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:gluco_scan/features/authentication/screens/signup/widgets/signup_header.dart';
import 'package:gluco_scan/common/widgets/buttons/social_buttons_row.dart';
import 'package:gluco_scan/features/authentication/screens/signup/widgets/terms_and_signin.dart';

import 'package:gluco_scan/utils/constants/colors.dart';


class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
    Widget build(BuildContext context) {
      final controller = Get.put(SignupController());
      return Scaffold(
        backgroundColor: LColors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                const SignupHeader(),
                const SizedBox(height: 32),
                LSignupForm(),
                const SizedBox(height: 24),
                const SocialButtonsRow(),
                const SizedBox(height: 16),
                TermsAndSignIn(),
                const SizedBox(height: 24),
                PrimaryButton(
                  label: 'Regístrate',
                  backgroundColor: LColors.primary,
                  foregroundColor: LColors.textWhite,
                  onPressed: () => controller.signup(),
                ),
              ],
            ),
          ),
        ),
      );
    }
}

