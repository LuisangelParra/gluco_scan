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
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
      child: Obx(() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButton('activity', 'Actividad\nFísica', Colors.teal, ctrl),
            const VerticalDivider(color: Colors.grey, thickness: 0.5, indent: 10, endIndent: 10),
            _buildButton('nutrition', 'Alimentación\nSaludable', Colors.black87, ctrl),
            const VerticalDivider(color: Colors.grey, thickness: 0.5, indent: 10, endIndent: 10),
            _buildButton('sleep', 'Sueño', const Color(0xFF5956A6), ctrl),
          ],
        );
      }),
    );
  }

  Widget _buildButton(String cat, String label, Color iconColor, HabitTrackingController ctrl) {
    final isSel = ctrl.selectedCategory.value == cat;
    return InkWell(
      onTap: () => ctrl.toggleCategory(cat),
      child: Container(
        decoration: BoxDecoration(
          color: isSel ? Colors.grey.shade300 : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(children: [Icon(HabitItem.iconForCategory(cat), color: iconColor, size: 22), const SizedBox(width:4), Text(label, style: TextStyle(color: iconColor, fontSize:13, fontWeight: FontWeight.w500))]),
      ),
    );
  }
}
