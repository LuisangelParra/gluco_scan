import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/common/widgets/buttons/primary_button.dart';
import 'package:gluco_scan/features/authentication/screens/login/widgets/auth_links.dart';
import 'package:gluco_scan/features/authentication/screens/login/widgets/login_form.dart';
import 'package:gluco_scan/features/authentication/screens/login/widgets/login_header.dart';
import 'package:gluco_scan/features/authentication/screens/login/widgets/social_buttons_row.dart';
import 'package:gluco_scan/routes/routes.dart';
import 'package:gluco_scan/utils/constants/colors.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _enter() {
    // TODO: lógica de login
  }

  @override
  Widget build(BuildContext context) {
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
              LoginForm(
                emailCtrl: _emailCtrl,
                passCtrl: _passCtrl,
              ),
              const SizedBox(height: 16),
              AuthLinks(
                onForgot: () => Get.toNamed(LRoutes.forgotPassword),
                onSignUp: () => Get.toNamed(LRoutes.signUp),
              ),
              const SizedBox(height: 24),
              const SocialButtonsRow(),
              const SizedBox(height: 24),
              PrimaryButton(
                label: 'Entrar a tu zona de control',
                backgroundColor: LColors.white,
                foregroundColor: LColors.primary,
                onPressed: _enter,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
