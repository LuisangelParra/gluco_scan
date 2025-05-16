// lib/features/habit_tracking/widgets/habit_detail_sheet.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/habit_tracking_controller.dart';
import '../models/habit_item.dart';

class HabitDetailSheet extends StatelessWidget {
  final HabitItem habit;
  const HabitDetailSheet({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<HabitTrackingController>();
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(20),
      child: Wrap(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: habit.backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(habit.icon, color: habit.iconColor, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(habit.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('Categoría: ${_categoryName(habit.category)}'),
          const SizedBox(height: 8),
          Text('Estado: ${habit.isCompleted ? "Completado" : "Pendiente"}'),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  ctrl.toggleComplete(habit);
                  Navigator.pop(context);
                },
                icon: Icon(habit.isCompleted ? Icons.check_box : Icons.check_box_outline_blank),
                label: Text(habit.isCompleted ? 'Marcar pendiente' : 'Marcar completado'),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  ctrl.removeHabit(habit);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.delete),
                label: const Text('Eliminar'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _categoryName(String c) {
    switch (c) {
      case 'activity':
        return 'Actividad Física';
      case 'nutrition':
        return 'Alimentación Saludable';
      case 'sleep':
        return 'Sueño';
      default:
        return 'Otro';
    }
  }
}
