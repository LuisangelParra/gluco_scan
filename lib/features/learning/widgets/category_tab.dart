// lib/features/learning/widgets/category_tab.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/features/learning/controllers/learning_controller.dart';
import 'package:gluco_scan/utils/constants/sizes.dart';

class CategoryTab extends StatelessWidget {
  final String keyName;
  final String label;
  const CategoryTab({
    super.key,
    required this.keyName,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<LearningController>();
    return Obx(() {
      final isSelected = ctrl.category.value == keyName;
      return Expanded(
        child: InkWell(
          onTap: () => ctrl.category.value = keyName,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: LSizes.sm),
            decoration: BoxDecoration(
              color: ctrl.headerBgColor.withValues(alpha: isSelected ? 1 : 0.2),
              borderRadius: BorderRadius.circular(LSizes.borderRadiusMd),
            ),
            alignment: Alignment.center,
            child: Text(label,
                style: const TextStyle(color: Colors.white, fontSize: 13)),
          ),
        ),
      );
    });
  }
}
