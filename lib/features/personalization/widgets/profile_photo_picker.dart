// lib/features/personalization/widgets/profile_photo_picker.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../utils/constants/colors.dart';
import '../controllers/user_controller.dart';

class ProfilePhotoPicker extends StatelessWidget {
  const ProfilePhotoPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final userCtrl = Get.find<UserController>();
    final user = userCtrl.user.value;

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: user.profilePicture.isNotEmpty
              ? NetworkImage(user.profilePicture)
              : null,
          child: user.profilePicture.isEmpty
              ? const Icon(Icons.person, size: 50)
              : null,
        ),
        IconButton(
          icon: userCtrl.imageUploading.value
              ? const CircularProgressIndicator()
              : const Icon(Icons.camera_alt),
          onPressed: () async {
            final picked = await ImagePicker()
                .pickImage(source: ImageSource.gallery, imageQuality: 80);
            if (picked == null) return;
            userCtrl.imageUploading.value = true;
            try {
              final url = await userCtrl.userRepository.uploadFile(
                'Users/ProfilePictures/${FirebaseAuth.instance.currentUser!.uid}',
                picked,
              );
              await userCtrl.userRepository
                  .updateSingleField({'profilePicture': url});
              userCtrl.user.update((u) => u?.profilePicture = url);
              Get.snackbar(
                'Listo',
                'Foto de perfil actualizada',
                backgroundColor: LColors.primary,
                colorText: Colors.white,
              );
            } catch (e) {
              Get.snackbar('Error', 'No se pudo subir la imagen');
            } finally {
              userCtrl.imageUploading.value = false;
            }
          },
        ),
      ],
    );
  }
}
