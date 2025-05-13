// lib/features/authentication/controllers/login/login_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:gluco_scan/data/repositories/authentication/authentication_repository.dart';
import 'package:gluco_scan/features/personalization/controllers/user_controller.dart';
import 'package:gluco_scan/utils/helpers/network_manager.dart';
import 'package:gluco_scan/utils/popups/full_screen_loader.dart';
import 'package:gluco_scan/utils/popups/loaders.dart';

import 'package:gluco_scan/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:gluco_scan/utils/exceptions/firebase_exceptions.dart';
import 'package:gluco_scan/utils/exceptions/platform_exceptions.dart';

import '../../../../utils/constants/image_strings.dart';

class LoginController extends GetxController {
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  void onInit() {
    super.onInit();
    final savedEmail = localStorage.read('REMEMBER_ME_EMAIL');
    final savedPass = localStorage.read('REMEMBER_ME_PASSWORD');
    if (savedEmail != null && savedPass != null) {
      email.text = savedEmail;
      password.text = savedPass;
      rememberMe.value = true;
    }
  }

  Future<void> emailAndPasswordSignIn() async {
    LFullScreenLoader.openLoadingDialog(
      'Iniciando sesión...',
      LImages.docerAnimation,
    );

    try {
      // Conexión
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        LFullScreenLoader.stopLoading();
        return LLoaders.errorSnackBar(
          title: 'Sin conexión',
          message: 'Revisa tu conexión a Internet.',
        );
      }

      // Validación
      if (!(loginFormKey.currentState?.validate() ?? false)) {
        LFullScreenLoader.stopLoading();
        return;
      }

      // Remember me
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Intentar login
      final userCred = await AuthenticationRepository.instance
          .loginUserWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );
      await userController.saveUserRecord(userCred);

      // Éxito: cerrar loader y redirigir
      LFullScreenLoader.stopLoading();
      AuthenticationRepository.instance.screenRedirect();

    } on LFirebaseAuthException catch (e) {
      // Excepción de Firebase Auth personalizada
      LFullScreenLoader.stopLoading();
      LLoaders.errorSnackBar(
        title: 'Error de autenticación',
        message: e.message, // tu mapeo en FirebaseAuthException
      );
    } on LFirebaseException catch (e) {
      // Otras excepciones de Firebase
      LFullScreenLoader.stopLoading();
      LLoaders.errorSnackBar(
        title: 'Error de Firebase',
        message: e.message,
      );
    } on LPlatformException catch (e) {
      // Errores de plataforma
      LFullScreenLoader.stopLoading();
      LLoaders.errorSnackBar(
        title: 'Error interno',
        message: e.message,
      );
    } catch (e) {
      // Cualquier otro error
      LFullScreenLoader.stopLoading();
      LLoaders.errorSnackBar(
        title: 'Error',
        message: 'Ocurrió un error inesperado.',
      );
    }
  }

  Future<void> googleSignIn() async {
    LFullScreenLoader.openLoadingDialog(
      'Iniciando sesión con Google...',
      LImages.docerAnimation,
    );
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        LFullScreenLoader.stopLoading();
        return LLoaders.errorSnackBar(
          title: 'Sin conexión',
          message: 'Revisa tu conexión a Internet.',
        );
      }

      final userCred =
          await AuthenticationRepository.instance.signInWithGoogle();
      await userController.saveUserRecord(userCred);

      LFullScreenLoader.stopLoading();
      AuthenticationRepository.instance.screenRedirect();

    } on LFirebaseAuthException catch (e) {
      LFullScreenLoader.stopLoading();
      LLoaders.errorSnackBar(
        title: 'Error de autenticación',
        message: e.message,
      );
    } on LFirebaseException catch (e) {
      LFullScreenLoader.stopLoading();
      LLoaders.errorSnackBar(
        title: 'Error de Firebase',
        message: e.message,
      );
    } on LPlatformException catch (e) {
      LFullScreenLoader.stopLoading();
      LLoaders.errorSnackBar(
        title: 'Error interno',
        message: e.message,
      );
    } catch (e) {
      LFullScreenLoader.stopLoading();
      LLoaders.errorSnackBar(
        title: 'Error',
        message: 'Ocurrió un error inesperado.',
      );
    }
  }
}
