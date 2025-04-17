import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/common/widgets/buttons/primary_button.dart';
import 'package:gluco_scan/routes/routes.dart';
import 'package:gluco_scan/utils/constants/colors.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LColors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo
              Image.asset(
                'assets/logos/logo-onboarding.png',
                width: 200,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 48),

              // Botón “Regístrate”
              PrimaryButton(
                label: 'Regístrate',
                backgroundColor: LColors.lavenderLight,
                foregroundColor: LColors.textWhite,
                onPressed: () => Get.toNamed(LRoutes.signUp),
              ),
              const SizedBox(height: 16),

              // Botón “Iniciar Sesión”
              PrimaryButton(
                label: 'Iniciar Sesión',
                backgroundColor: LColors.mint,
                foregroundColor: LColors.secondary,
                onPressed: () => Get.toNamed(LRoutes.login),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
