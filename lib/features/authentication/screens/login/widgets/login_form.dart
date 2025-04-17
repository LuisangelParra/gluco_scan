import 'package:flutter/material.dart';
import 'package:gluco_scan/common/widgets/inputs/input_field.dart';


/// Campos de email y contraseña.
class LoginForm extends StatelessWidget {
  final TextEditingController emailCtrl;
  final TextEditingController passCtrl;

  const LoginForm({
    super.key,
    required this.emailCtrl,
    required this.passCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LInputField(
          controller: emailCtrl,
          hintText: '@gmail.com',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        LInputField(
          controller: passCtrl,
          hintText: '................',
          obscureText: true,
        ),
      ],
    );
  }
}
