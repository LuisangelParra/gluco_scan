// lib/common/widgets/forms/terms_and_signin.dart

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/features/authentication/controllers/signup/signup_controller.dart';

import 'package:gluco_scan/routes/routes.dart';
import 'package:gluco_scan/utils/constants/colors.dart';
import 'package:gluco_scan/utils/constants/sizes.dart';
import 'package:gluco_scan/utils/helpers/helper_functions.dart';


/// Checkbox de Términos y Condiciones + link a Login
class TermsAndSignIn extends StatelessWidget {
  const TermsAndSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    final isDark = THelperFunctions.isDarkMode(context);

    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: controller.privacyPolicy.value,
                  onChanged: (_) =>
                      controller.privacyPolicy.toggle(),
                ),
              ),
              const SizedBox(width: LSizes.spaceBtwItems),
              Expanded(
                child: Text(
                  "Acepto los Términos y condiciones de uso y la política de privacidad",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: LSizes.spaceBtwItems),
          Center(
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodySmall!
                    .copyWith(color: isDark ? LColors.white : LColors.black),
                children: [
                  const TextSpan(text: '¿Ya tienes cuenta? '),
                  TextSpan(
                    text: 'Inicia Sesión',
                    style: TextStyle(
                      color: isDark ? LColors.white : LColors.primary,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor:
                          isDark ? LColors.white : LColors.primary,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () => Get.offNamed(LRoutes.login),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
