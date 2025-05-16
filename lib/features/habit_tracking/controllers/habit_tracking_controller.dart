// lib/features/habit_tracking/controllers/habit_tracking_controller.dart

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/habit_item.dart';
import '../services/habit_service.dart';

class HabitTrackingController extends GetxController {
  final _service = HabitService();
  

  // Estado reactivo
  final habits = <HabitItem>[].obs;
  final selectedCategory = RxnString(null);

  @override
  void onInit() {
    super.onInit();
    loadHabits();
  }

  Future<void> loadHabits() async {
    final all = await _service.fetchHabits();
    habits.assignAll(all);
  }

  List<HabitItem> get filteredHabits {
    final cat = selectedCategory.value;
    if (cat == null) return habits;
    return habits.where((h) => h.category == cat).toList();
  }

  void toggleCategory(String category) {
    if (selectedCategory.value == category) {
      selectedCategory.value = null;
    } else {
      selectedCategory.value = category;
    }
  }

  Future<void> addHabit(String title, String category, String quantity) async {
    final newHabit = HabitItem(
      id: const Uuid().v4(),
      title: title,
      subtitle: '${_categoryName(category)} · Hoy',
      category: category,
      icon: HabitItem.iconForCategory(category),
      backgroundColor: HabitItem.bgColorForCategory(category),
      iconColor: HabitItem.iconColorForCategory(category),
      isCompleted: false,
      quantity: quantity,
    );
    await _service.addHabit(newHabit);
    habits.add(newHabit);
  }

  Future<void> removeHabit(HabitItem h) async {
    await _service.removeHabit(h.id);
    habits.remove(h);
  }

  Future<void> toggleComplete(HabitItem h) async {
    h.isCompleted = !h.isCompleted;
    await _service.updateHabit(h);
    habits.refresh();
  }

  void showAddDialog(BuildContext context) {
    // Lógica para mostrar tu AddHabitDialog (ver más abajo)
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
