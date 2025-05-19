// lib/features/personalization/screens/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../controllers/user_controller.dart';
import '../widgets/profile_photo_picker.dart';
import '../widgets/profile_info_form.dart';
import '../widgets/delete_account_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userCtrl = Get.find<UserController>();

    return Scaffold(
      backgroundColor: LColors.primary.withValues(alpha: 0.5),
      appBar: AppBar(
        title: const Text('Mi perfil', style: TextStyle(color: LColors.textWhite),) ,
        backgroundColor: LColors.primary,
      ),
      body: Obx(() {
        if (userCtrl.profileLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(LSizes.md),
          child: Column(
            children: const [
              ProfilePhotoPicker(),
              SizedBox(height: LSizes.lg),
              ProfileInfoForm(),
              Spacer(),
              DeleteAccountButton(),
            ],
          ),
        );
      }),
    );
  }
}
