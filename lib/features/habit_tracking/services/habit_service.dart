// lib/features/habit_tracking/services/habit_service.dart

import 'package:uuid/uuid.dart';
import '../models/habit_item.dart';
import 'package:flutter/material.dart';


class HabitService {
  //final _uuid = const Uuid();

  /// Mock inicial
  final List<HabitItem> _storage = [
    HabitItem(
      id: const Uuid().v4(),
      title: '30 min de caminata ligera',
      subtitle: 'Actividad Física · Hoy',
      category: 'activity',
      icon: Icons.directions_run,
      backgroundColor: Colors.teal.shade50,
      iconColor: Colors.teal,
      isCompleted: true,
      quantity: '30 min',
    ),
    // ... otros ítems ...
  ];

  Future<List<HabitItem>> fetchHabits() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_storage);
  }

  Future<void> addHabit(HabitItem item) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _storage.add(item);
  }

  Future<void> removeHabit(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _storage.removeWhere((h) => h.id == id);
  }

  Future<void> updateHabit(HabitItem updated) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final idx = _storage.indexWhere((h) => h.id == updated.id);
    if (idx >= 0) _storage[idx] = updated;
  }
}
