import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/common/widgets/buttons/primary_button.dart';
import 'package:gluco_scan/features/authentication/controllers/login/login_controller.dart';
import 'package:gluco_scan/features/authentication/screens/login/widgets/auth_links.dart';
import 'package:gluco_scan/features/authentication/screens/login/widgets/login_form.dart';
import 'package:gluco_scan/features/authentication/screens/login/widgets/login_header.dart';
import 'package:gluco_scan/common/widgets/buttons/social_buttons_row.dart';
import 'package:gluco_scan/routes/routes.dart';
import 'package:gluco_scan/utils/constants/colors.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      backgroundColor: LColors.primary, // lila
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              const LoginHeader(),
              const SizedBox(height: 32),
              LoginForm(),
              const SizedBox(height: 16),
              AuthLinks(
                onForgot: () => Get.offNamed(LRoutes.forgotPassword),
                onSignUp: () => Get.offNamed(LRoutes.signUp),
              ),
              const SizedBox(height: 24),
              const SocialButtonsRow(),
              const SizedBox(height: 24),
              PrimaryButton(
                label: 'Entrar a tu zona de control',
                backgroundColor: LColors.white,
                foregroundColor: LColors.primary,
                onPressed: () {
                  // Dentro de la acción de pulsar, validamos y si pasa, procedemos
                  if (controller.loginFormKey.currentState?.validate() ?? false) {
                    controller.emailAndPasswordSignIn();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
