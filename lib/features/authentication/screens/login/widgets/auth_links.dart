import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// “Olvide mi correo/contraseña” y “¿No tienes una cuenta? Crea una”
class AuthLinks extends StatelessWidget {
  final VoidCallback onForgot;
  final VoidCallback onSignUp;

  const AuthLinks({
    super.key,
    required this.onForgot,
    required this.onSignUp,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Colors.white;
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: onForgot,
            child: Text('Olvidé mi correo/contraseña',
                style: TextStyle(color: textColor)),
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: TextStyle(color: textColor),
            children: [
              const TextSpan(text: '¿No tienes una cuenta aún? '),
              TextSpan(
                text: 'Crea una',
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()..onTap = onSignUp,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
