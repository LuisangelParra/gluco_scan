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
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: habit.backgroundColor,
          child: Icon(habit.icon, color: habit.iconColor),
        ),
        title: Text(habit.title),
        subtitle: Text(habit.subtitle),
        trailing: Checkbox(
          value: habit.isCompleted,
          onChanged: (_) => ctrl.toggleComplete(habit),
        ),
        onTap: () => showModalBottomSheet(
          context: context,
          builder: (_) => HabitDetailSheet(habit: habit),
        ),
      ),
    );
  }
}
