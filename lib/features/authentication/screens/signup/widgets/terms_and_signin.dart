// lib/widgets/terms_and_signin.dart

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Checkbox + texto de “Acepto términos y condiciones”
/// y link “¿Ya tienes una cuenta? Inicia Sesión”
class TermsAndSignIn extends StatelessWidget {
  final bool accepted;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onLoginTap;

  const TermsAndSignIn({
    super.key,
    required this.accepted,
    required this.onChanged,
    required this.onLoginTap,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Checkbox(
              value: accepted,
              onChanged: onChanged,
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: Text('Acepto términos y condiciones'),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Center(
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: textColor),
              children: [
                const TextSpan(text: '¿Ya tienes una cuenta? '),
                TextSpan(
                  text: 'Inicia Sesión',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = onLoginTap,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
