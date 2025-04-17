import 'package:flutter/material.dart';
import 'package:gluco_scan/common/widgets/inputs/input_field.dart';

/// Formulario de campos: nombre, correo y contraseña.
class SignupForm extends StatelessWidget {
  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController passCtrl;

  const SignupForm({
    super.key,
    required this.nameCtrl,
    required this.emailCtrl,
    required this.passCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LInputField(
          controller: nameCtrl,
          hintText: 'Tu nombre',
        ),
        const SizedBox(height: 16),
        LInputField(
          controller: emailCtrl,
          hintText: 'Correo electrónico',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        LInputField(
          controller: passCtrl,
          hintText: 'Contraseña',
          obscureText: true,
        ),
      ],
    );
  }
}
