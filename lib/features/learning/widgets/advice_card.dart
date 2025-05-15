// lib/features/learning/widgets/advice_card.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/features/learning/controllers/learning_controller.dart';

import 'package:gluco_scan/utils/constants/sizes.dart';

class AdviceCard extends StatelessWidget {
  const AdviceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<LearningController>();
    return Obx(() {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: LSizes.md,
          vertical: LSizes.sm,
        ),
        decoration: BoxDecoration(
          color: ctrl.headerBgColor.withValues(alpha: .2),
          borderRadius: BorderRadius.circular(LSizes.borderRadiusMd),
        ),
        child: Row(
          children: [
            Icon(ctrl.headerIcon, color: ctrl.headerBgColor),
            const SizedBox(width: LSizes.sm),
            Expanded(
              child: Text(
                ctrl.advice.value,
                style: const TextStyle(color: Colors.black87, fontSize: 14),
              ),
            ),
          ],
        ),
      );
    });
  }
}
