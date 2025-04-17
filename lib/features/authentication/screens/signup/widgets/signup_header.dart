import 'package:flutter/material.dart';

/// Cabecera de la pantalla de Signup con los dos logos.
class SignupHeader extends StatelessWidget {
  const SignupHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Logo circular
        Image.asset(
          'assets/logos/logo.png',
          width: 100,
          height: 100,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 24),
        // Logo con texto
        Image.asset(
          'assets/logos/logo-signup.png',
          width: 180,
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}
