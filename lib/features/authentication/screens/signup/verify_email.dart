// lib/features/authentication/screens/signup/verify_email.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/features/authentication/controllers/signup/verify_email_controller.dart';
import 'package:gluco_scan/utils/constants/colors.dart';
import 'package:gluco_scan/common/widgets/buttons/primary_button.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});
  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      backgroundColor: LColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: LColors.primary),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Container(
                decoration: const BoxDecoration(
                  color: LColors.lavenderLight,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(24),
                child: const Icon(
                  Icons.email_outlined,
                  size: 48,
                  color: LColors.primary,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Verifica tu correo electrónico',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: LColors.primary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              if (email != null)
                Text(
                  email!,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 16),
              Text(
                'Hemos enviado un enlace a tu correo. '
                'Revisa tu bandeja de entrada y haz clic en el enlace '
                'para verificar tu cuenta.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                label: 'Reenviar enlace',
                backgroundColor: LColors.primary,
                foregroundColor: LColors.textWhite,
                onPressed: () => controller.sendEmailVerification(),
              ),
              const SizedBox(height: 16),
              Center(
                child: GestureDetector(
                  onTap: () => controller.checkEmailVerificationStatus(),
                  child: const Text(
                    'Ya verifiqué mi correo',
                    style: TextStyle(
                      color: LColors.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
