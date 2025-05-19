// lib/features/habit_tracking/widgets/habit_progress_card.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/habit_tracking_controller.dart';

class HabitProgressCard extends StatelessWidget {
  const HabitProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<HabitTrackingController>();
    return Obx(() {
      final total     = ctrl.allHabits.length;
      final completed = ctrl.allHabits.where((h) => h.isCompleted).length;
      final pct       = total > 0 ? completed / total : 0.0;

      return Card(
        color: Colors.white24,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Progreso de hoy',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: pct,
                backgroundColor: Colors.white12,
                color: Colors.white,
                minHeight: 6,
              ),
              const SizedBox(height: 8),
              Text(
                '${completed} de ${total} completados • ${(pct * 100).toStringAsFixed(0)}%',
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      );
    });
  }
}
