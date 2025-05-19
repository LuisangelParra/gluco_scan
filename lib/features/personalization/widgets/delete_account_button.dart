// lib/features/personalization/widgets/delete_account_button.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../routes/routes.dart';

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({super.key});

  void _confirmDelete(BuildContext context) {
    Get.defaultDialog(
      title: 'Borrar cuenta',
      middleText:
          'Esto cerrará tu sesión pero no eliminará tus datos. ¿Continuar?',
      textCancel: 'Cancelar',
      textConfirm: 'Borrar',
      confirmTextColor: Colors.white,
      onConfirm: () async {
        await FirebaseAuth.instance.currentUser?.delete();
        await FirebaseAuth.instance.signOut();
        Get.offAllNamed(LRoutes.login);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
        onPressed: () => _confirmDelete(context),
        child: const Text('Borrar cuenta'),
      ),
    );
  }
}
