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
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: habit.backgroundColor,
              child: Icon(habit.icon, color: habit.iconColor),
            ),
            title: Text(habit.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text(habit.subtitle),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  ctrl.toggleComplete(habit);
                  Navigator.pop(context);
                },
                icon: Icon(habit.isCompleted ? Icons.undo : Icons.check),
                label: Text(habit.isCompleted ? 'Marcar pendiente' : 'Marcar\ncompletado'),
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
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
