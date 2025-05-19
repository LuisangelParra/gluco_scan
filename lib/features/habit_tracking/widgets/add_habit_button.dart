import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_habit_dialog.dart';

class AddHabitButton extends StatelessWidget {
  const AddHabitButton({super.key});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.add),
      label: const Text('Añadir hábito'),
      onPressed: () {
        // Abre tu AddHabitDialog
        Get.dialog(const AddHabitDialog());
      },
    );
  }
}
