import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/common/widgets/buttons/primary_button.dart';
import 'package:gluco_scan/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:gluco_scan/features/authentication/screens/signup/widgets/signup_header.dart';
import 'package:gluco_scan/features/authentication/screens/signup/widgets/signup_social_buttons.dart';
import 'package:gluco_scan/features/authentication/screens/signup/widgets/terms_and_signin.dart';
import 'package:gluco_scan/routes/routes.dart';
import 'package:gluco_scan/utils/constants/colors.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _accepted = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!_accepted) return;
    // TODO: tu lógica de registro
  }

  @override
  Widget build(BuildContext context) {
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
              SignupForm(
                nameCtrl: _nameCtrl,
                emailCtrl: _emailCtrl,
                passCtrl: _passCtrl,
              ),
              const SizedBox(height: 24),
              const SignupSocialButtons(),
              const SizedBox(height: 16),
              TermsAndSignIn(
                accepted: _accepted,
                onChanged: (v) => setState(() => _accepted = v ?? false),
                onLoginTap: () => Get.toNamed(LRoutes.login),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: 'Regístrate',
                backgroundColor: LColors.primary,
                foregroundColor: LColors.textWhite,
                onPressed: (){},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
