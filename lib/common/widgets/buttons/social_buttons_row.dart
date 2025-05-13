import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/common/widgets/buttons/social_button.dart';
import 'package:gluco_scan/features/authentication/controllers/login/login_controller.dart';
import 'package:gluco_scan/utils/constants/colors.dart';


/// Botones para login social (Facebook / Google).
class SocialButtonsRow extends StatelessWidget {
  const SocialButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      children: [
        Expanded(
          child: SocialButton(
            label: 'Facebook',
            icon: Icons.facebook,
            backgroundColor: LColors.facebook,
            foregroundColor: LColors.textWhite,
            onPressed: () {
              // TODO: Facebook login
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SocialButton(
            label: 'Google',
            icon: Icons.android, // reemplaza con el icono de Google que prefieras
            backgroundColor: LColors.offWhite,
            foregroundColor: LColors.googleRed,
            onPressed: () => controller.googleSignIn(),
          ),
        ),
      ],
    );
  }
}
