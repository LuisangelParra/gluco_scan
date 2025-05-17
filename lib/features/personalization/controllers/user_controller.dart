// lib/features/personalization/controllers/user_controller.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:gluco_scan/data/repositories/authentication/authentication_repository.dart';
import 'package:gluco_scan/data/repositories/user/user_repository.dart';
import 'package:gluco_scan/features/authentication/screens/login/login.dart';
import 'package:gluco_scan/features/personalization/models/user_model.dart';
import 'package:gluco_scan/utils/helpers/network_manager.dart';
import 'package:gluco_scan/utils/popups/full_screen_loader.dart';
import 'package:gluco_scan/utils/popups/loaders.dart';
import '../../../utils/constants/image_strings.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final hidePassword = false.obs;
  final imageUploading = false.obs;

  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();

  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final fetched = await userRepository.fetchUserDetails();
      user(fetched);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }


  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // Refresh user record
      await fetchUserRecord();
      if (user.value.id.isEmpty) {
        // Save user record to firestore
        if (userCredentials != null) {
          final name = userCredentials.user!.displayName ?? '';

          final user = UserModel(
            id: userCredentials.user!.uid,
            name: name,
            email: userCredentials.user!.email ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
            //medicalHistoryFile: '', // campo inicial vacío
          );

          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      LLoaders.warningSnackBar(
        title: 'Data no saved',
        message: 'Something went wrong. You can re-save data in your profile.',
      );
    }
  }

  // void deleteAccountWarningPopup() {
  //   Get.defaultDialog(
  //     title: 'Delete Account',
  //     contentPadding: const EdgeInsets.all(LSizes.md),
  //     middleText:
  //         'Are you sure you want to delete your account permanently?, This action is not reversible and all your data will be removed permanently.',
  //     confirm: ElevatedButton(
  //       onPressed: () async => deleteUserAccount(),
  //       style: ElevatedButton.styleFrom(
  //           backgroundColor: Colors.red,
  //           side: const BorderSide(color: Colors.red)),
  //       child: const Padding(
  //         padding: EdgeInsets.symmetric(horizontal: LSizes.lg),
  //         child: Text('Delete'),
  //       ),
  //     ),
  //     cancel: OutlinedButton(
  //         onPressed: () => Navigator.of(Get.overlayContext!).pop(),
  //         child: const Text('Cancel')),
  //   );
  // }

  // void deleteUserAccount() async {
  //   try {
  //     LFullScreenLoader.openLoadingDialog(
  //         'We are deleting your account...', LImages.docerAnimation);

  //     final auth = AuthenticationRepository.instance;
  //     final provider =
  //         auth.authUser!.providerData.map((e) => e.providerId).first;

  //     if (provider == 'google.com') {
  //       await auth.signInWithGoogle();
  //       await auth.deleteAccount();
  //       LFullScreenLoader.stopLoading();
  //       Get.offAll(() => const LoginScreen());
  //     } else if (provider == 'password') {
  //       LFullScreenLoader.stopLoading();
  //       Get.to(() => const ReAuthLoginForm());
  //     }
  //   } catch (e) {
  //     LFullScreenLoader.stopLoading();
  //     LLoaders.errorSnackBar(
  //       title: 'Oh Snap!',
  //       message: e.toString(),
  //     );
  //   }
  // }

  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      LFullScreenLoader.openLoadingDialog(
          'Procesando...', LImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        LFullScreenLoader.stopLoading();
        return;
      }

      if (!reAuthFormKey.currentState!.validate()) {
        LFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
        verifyEmail.text.trim(),
        verifyPassword.text.trim(),
      );

      await AuthenticationRepository.instance.deleteAccount();

      LFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      LFullScreenLoader.stopLoading();
      LLoaders.errorSnackBar(
        title: 'Error',
        message: e.toString(),
      );
    }
  }

  // /// (Opcional) Método para subir y guardar el JSON de historia clínica
  // Future<void> uploadMedicalHistoryFile(XFile file) async {
  //   try {
  //     profileLoading.value = true;

  //     // Usa uploadImage para subir cualquier archivo (JSON, PDF, etc.)
  //     final fileUrl = await userRepository.uploadFile(
  //       'Users/Files/MedicalHistory',
  //       file,
  //     );

  //     // Actualiza el campo MedicalHistoryFile en Firestore
  //     await userRepository.updateSingleField({
  //       'MedicalHistoryFile': fileUrl,
  //     });

  //     // Refleja el cambio en el modelo reactivo
  //     user.value.medicalHistoryFile = fileUrl;
  //     user.refresh();

  //     LLoaders.successSnackBar(
  //       title: '¡Listo!',
  //       message: 'Historia clínica cargada correctamente.',
  //     );
  //   } catch (e) {
  //     LLoaders.errorSnackBar(
  //       title: 'Error',
  //       message: 'No se pudo cargar el archivo: $e',
  //     );
  //   } finally {
  //     profileLoading.value = false;
  //   }
  // }
  
}
