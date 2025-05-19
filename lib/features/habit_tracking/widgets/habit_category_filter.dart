// lib/features/habit_tracking/widgets/habit_category_filter.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/habit_item.dart';
import '../controllers/habit_tracking_controller.dart';

class HabitCategoryFilter extends StatelessWidget {
  const HabitCategoryFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<HabitTrackingController>();
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Obx(() {
        return Row(
          children: [
            Expanded(
              child: _buildButton(
                cat: 'activity',
                label: 'Actividad\nFísica',
                iconColor: Colors.teal,
                ctrl: ctrl,
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: _buildButton(
                cat: 'nutrition',
                label: 'Alimentación\nSaludable',
                iconColor: Colors.green,
                ctrl: ctrl,
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: _buildButton(
                cat: 'sleep',
                label: 'Sueño',
                iconColor: const Color(0xFF5956A6),
                ctrl: ctrl,
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildButton({
    required String cat,
    required String label,
    required Color iconColor,
    required HabitTrackingController ctrl,
  }) {
    final isSelected = ctrl.selectedCategory.value == cat;
    return InkWell(
      onTap: () => ctrl.toggleCategory(cat),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        decoration: BoxDecoration(
          color: isSelected ? iconColor.withOpacity(0.15) : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              HabitItem.iconForCategory(cat),
              color: iconColor,
              size: 20,
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: iconColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
