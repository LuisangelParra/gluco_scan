// lib/screens/forget_password.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/utils/constants/colors.dart';
import 'package:gluco_scan/routes/routes.dart';
import 'package:gluco_scan/common/widgets/inputs/input_field.dart';
import 'package:gluco_scan/common/widgets/buttons/primary_button.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  void _sendResetLink() {
    final email = _emailCtrl.text.trim();
    if (email.isEmpty) {
      Get.snackbar('Error', 'Por favor ingresa tu correo electrónico',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }
    // TODO: Lógica para enviar el enlace de restablecimiento
    Get.snackbar('Enviado', 'Revisa tu correo para restablecer la contraseña',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LColors.white,
      // Si quieres un back button automático:
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: LColors.primary),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),

              // Título
              Text(
                'Olvidé mi contraseña',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: LColors.primary),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // Subtítulo explicativo
              Text(
                'Ingresa tu correo electrónico y te enviaremos un enlace para restablecer tu contraseña.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),

              // Campo de email
              LInputField(
                controller: _emailCtrl,
                hintText: 'Correo electrónico',
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 24),

              // Botón enviar enlace
              PrimaryButton(
                label: 'Enviar enlace',
                backgroundColor: LColors.primary,
                foregroundColor: LColors.textWhite,
                onPressed: _sendResetLink,
              ),

              const SizedBox(height: 16),

              // Link para volver a login
              Center(
                child: GestureDetector(
                  onTap: () => Get.toNamed(LRoutes.login),
                  child: Text(
                    '¿Recordaste tu contraseña? Inicia Sesión',
                    style: const TextStyle(
                      color: LColors.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
