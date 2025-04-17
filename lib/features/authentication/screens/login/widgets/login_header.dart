import 'package:flutter/material.dart';
import 'package:gluco_scan/features/authentication/screens/login/widgets/star_rating.dart';

/// Saludo “¡Hola, estás de vuelta!” + estrellas.
class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        StarRating(),
        SizedBox(height: 24),
        Text(
          '¡Hola,\nestás de vuelta!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
