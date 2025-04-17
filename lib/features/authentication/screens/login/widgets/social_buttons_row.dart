import 'package:flutter/material.dart';
import 'package:gluco_scan/common/widgets/buttons/social_button.dart';
import 'package:gluco_scan/utils/constants/colors.dart';

/// Fila de botones Facebook / Google.
class SocialButtonsRow extends StatelessWidget {
  const SocialButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SocialButton(
            label: 'Facebook',
            icon: Icons.facebook,
            backgroundColor: LColors.facebook,
            foregroundColor: LColors.textWhite,
            onPressed: () {},
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SocialButton(
            label: 'Google',
            icon: Icons.g_mobiledata, // o el ícono de Google que prefieras
            backgroundColor: LColors.offWhite,
            foregroundColor: LColors.googleRed,
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
