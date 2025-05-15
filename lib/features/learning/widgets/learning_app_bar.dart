// lib/features/learning/widgets/learning_app_bar.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/features/learning/controllers/learning_controller.dart';

class LearningAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LearningAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<LearningController>();
    return Obx(() {
      return AppBar(
        backgroundColor: ctrl.headerBgColor,
        elevation: 0,
        title: const Text(
          'Aprende sobre la diabetes',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
        actions: [
          Icon(ctrl.headerIcon, color: Colors.white),
          const SizedBox(width: 16),
        ],
      );
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);
}
