// lib/features/authentication/screens/reset_password/reset_password_screen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gluco_scan/utils/constants/colors.dart';
import 'package:gluco_scan/utils/constants/sizes.dart';
import 'package:gluco_scan/utils/constants/image_strings.dart';
import 'package:gluco_scan/common/widgets/buttons/primary_button.dart';
import 'package:gluco_scan/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:gluco_scan/routes/routes.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.clear, color: LColors.primary),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(LSizes.defaultSpace),
        child: Column(
          children: [
            // Ilustración
            Image.asset(
              LImages.deliveredEmailIllustration,
              width: width * 0.6,
            ),
            const SizedBox(height: LSizes.spaceBtwSections),

            // Email enviado
            Text(
              email,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: LSizes.spaceBtwItems),

            // Título
            Text(
              'Restablecer contraseña',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: LColors.primary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: LSizes.spaceBtwItems),

            // Subtítulo
            Text(
              'Hemos enviado un enlace a tu correo para que puedas restablecer tu contraseña.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: LSizes.spaceBtwSections),

            // Botón Continuar (va al login)
            PrimaryButton(
              label: 'Continuar',
              backgroundColor: LColors.primary,
              foregroundColor: LColors.textWhite,
              onPressed: () => Get.offAllNamed(LRoutes.login),
            ),
            const SizedBox(height: LSizes.spaceBtwItems),

            // Botón Reenviar correo
            TextButton(
              onPressed: () => ForgetPasswordController.instance
                  .resendPasswordResetEmail(email),
              child: const Text('Reenviar correo'),
            ),
          ],
        ),
      ),
    );
  }
}
