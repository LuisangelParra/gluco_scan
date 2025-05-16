// lib/features/habit_tracking/widgets/add_habit_button.dart

import 'package:flutter/material.dart';
import 'package:gluco_scan/features/habit_tracking/widgets/add_habit_dialog.dart';

class AddHabitButton extends StatelessWidget {
  const AddHabitButton({super.key});
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => showDialog(
        context: context,
        builder: (_) => const AddHabitDialog(),
      ),
      icon: const Icon(Icons.add, color: Colors.black54, size: 24),
      label: const Text('Añadir hábito', style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w500)),
      style: TextButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
    );
  }
}
