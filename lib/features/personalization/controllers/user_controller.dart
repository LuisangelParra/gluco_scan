// lib/features/personalization/controllers/user_controller.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
      // Si aún no existe registro en Firestore, lo creamos
      if (user.value.id.isEmpty && userCredentials != null) {
        final fbUser = userCredentials.user!;
        final newUser = UserModel(
          id: fbUser.uid,
          name: fbUser.displayName ?? '',
          email: fbUser.email ?? '',
          profilePicture: fbUser.photoURL ?? '',
        );
        await userRepository.saveUserRecord(newUser);
        user(newUser);
      }
    } catch (e) {
      LLoaders.warningSnackBar(
        title: 'Advertencia',
        message:
            'No se pudo guardar los datos. Puedes reintentar en tu perfil.',
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

  /// Upload profile picture
  Future<void> uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );
      if (image != null) {
        imageUploading.value = true;
        final imageUrl = await userRepository.uploadImage(
          'Users/Images/Profile',
          image,
        );

        // Actualiza foto de perfil en Firestore
        await userRepository.updateSingleField({'ProfilePicture': imageUrl});

        user.value.profilePicture = imageUrl;
        user.refresh();
        LLoaders.successSnackBar(
          title: '¡Listo!',
          message: 'Se actualizó tu imagen de perfil.',
        );
      }
    } catch (e) {
      LLoaders.errorSnackBar(
        title: 'Error',
        message: 'Algo salió mal: $e',
      );
    } finally {
      imageUploading.value = false;
    }
  }
}
