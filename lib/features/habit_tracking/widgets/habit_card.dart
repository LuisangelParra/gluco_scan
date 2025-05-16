// lib/features/habit_tracking/widgets/habit_card.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/features/habit_tracking/widgets/habit_detail_sheet.dart';
import '../models/habit_item.dart';
import '../controllers/habit_tracking_controller.dart';

class HabitCard extends StatelessWidget {
  final HabitItem habit;
  const HabitCard(this.habit, {super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<HabitTrackingController>();
    return Dismissible(
      key: ValueKey(habit.id),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => ctrl.removeHabit(habit),
      child: GestureDetector(
        onTap: () => _showDetails(context, ctrl),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: habit.backgroundColor, borderRadius: BorderRadius.circular(10)),
                child: Icon(habit.icon, color: habit.iconColor, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(habit.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  if (habit.quantity != null) Text(habit.quantity!, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                  Text(habit.subtitle, style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
                ]),
              ),
              Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey.shade400),
            ],
          ),
        ),
      ),
    );
  }

  void _showDetails(BuildContext context, HabitTrackingController ctrl) {
    showModalBottomSheet(
      context: context,
      builder: (_) => HabitDetailSheet(habit: habit),
    );
  }
}
