// lib/features/authentication/screens/signup/verify_email.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/utils/constants/colors.dart';
import 'package:gluco_scan/common/widgets/buttons/primary_button.dart';
import 'package:gluco_scan/routes/routes.dart';
import 'package:gluco_scan/utils/popups/loaders.dart';

class VerifyEmailScreen extends StatefulWidget {
  /// El correo que se usó para el registro, opcional.
  final String? email;

  const VerifyEmailScreen({super.key, this.email});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final _auth = FirebaseAuth.instance;

  Future<void> _sendVerificationLink() async {
    try {
      final user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        LLoaders.successSnackBar(
          title: 'Enviado',
          message: 'Revisa tu correo (${widget.email ?? 'tu correo'}) para verificar tu cuenta',
        );
      } else {
        LLoaders.warningSnackBar(
          title: 'Aviso',
          message: 'Tu correo ya está verificado',
        );
      }
    } catch (e) {
      LLoaders.errorSnackBar(
        title: 'Error',
        message: 'No se pudo enviar el enlace: ${e.toString()}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LColors.white,
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
              Container(
                decoration: const BoxDecoration(
                  color: LColors.lavenderLight,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(24),
                child: const Icon(
                  Icons.email_outlined,
                  size: 48,
                  color: LColors.primary,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Verifica tu correo electrónico',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: LColors.primary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              if (widget.email != null)
                Text(
                  widget.email!,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 16),
              Text(
                'Hemos enviado un enlace a tu correo. '
                'Revisa tu bandeja de entrada y haz clic en el enlace '
                'para verificar tu cuenta.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                label: 'Reenviar enlace',
                backgroundColor: LColors.primary,
                foregroundColor: LColors.textWhite,
                onPressed: _sendVerificationLink,
              ),
              const SizedBox(height: 16),
              Center(
                child: GestureDetector(
                  onTap: () => Get.offAllNamed(LRoutes.login),
                  child: const Text(
                    'Ya verifiqué mi correo',
                    style: TextStyle(
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
