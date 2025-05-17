// lib/features/authentication/controllers/signup_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/features/personalization/models/user_model.dart';
import 'package:gluco_scan/data/repositories/authentication/authentication_repository.dart';
import 'package:gluco_scan/data/repositories/user/user_repository.dart';
import 'package:gluco_scan/features/authentication/screens/signup/verify_email.dart';
import 'package:gluco_scan/utils/constants/image_strings.dart';
import 'package:gluco_scan/utils/helpers/network_manager.dart';
import 'package:gluco_scan/utils/popups/full_screen_loader.dart';
import 'package:gluco_scan/utils/popups/loaders.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// Ocultar/mostrar contraseña
  final hidePassword = true.obs;

  /// Aceptación de términos y condiciones
  final privacyPolicy = false.obs;

  /// Controllers para los campos del formulario
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  /// Key del formulario
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  @override
  void onClose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.onClose();
  }

  Future<void> signup() async {
    try {
      // Iniciar loader de pantalla
      LFullScreenLoader.openLoadingDialog(
        'Procesando información...',
        LImages.docerAnimation,
      );

      // Verificar conexión
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        LFullScreenLoader.stopLoading();
        LLoaders.errorSnackBar(
          title: 'Sin conexión',
          message: 'Revisa tu conexión a Internet.',
        );
        return;
      }

      // Validar formulario
      if (!signupFormKey.currentState!.validate()) {
        LFullScreenLoader.stopLoading();
        return;
      }

      // Verificar términos
      if (!privacyPolicy.value) {
        LFullScreenLoader.stopLoading();
        LLoaders.warningSnackBar(
          title: 'Atención',
          message: 'Debes aceptar términos y condiciones.',
        );
        return;
      }

      // Registrar usuario en Firebase Auth
      final userCredential = await AuthenticationRepository.instance
          .registerUserWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      // Guardar datos del usuario en Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        name: name.text.trim(),
        email: email.text.trim(),
        profilePicture: '',
        //medicalHistoryFile: '',
      );
      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Detener loader
      LFullScreenLoader.stopLoading();

      // Mostrar mensaje de éxito
      LLoaders.successSnackBar(
        title: '¡Listo!',
        message: 'Cuenta creada. Verifica tu correo para continuar.',
      );

      // Navegar a pantalla de verificación
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      LFullScreenLoader.stopLoading();
      LLoaders.errorSnackBar(
        title: 'Error',
        message: e.toString(),
      );
    }
  }
}
