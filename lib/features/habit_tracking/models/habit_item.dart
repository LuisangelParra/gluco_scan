// lib/features/habit_tracking/models/habit_item.dart
import 'package:flutter/material.dart';

class HabitItem {
  final String id;
  final String title;
  final String subtitle;
  final String category;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  bool isCompleted;
  final String? quantity;

  HabitItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    this.isCompleted = false,
    this.quantity,
  });

  // Para serializar / persistir
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'category': category,
        'isCompleted': isCompleted,
        'quantity': quantity,
      };

  factory HabitItem.fromJson(Map<String, dynamic> json) => HabitItem(
        id: json['id'] as String,
        title: json['title'] as String,
        subtitle: json['subtitle'] as String,
        category: json['category'] as String,
        icon: iconForCategory(json['category'] as String),
        backgroundColor:
            bgColorForCategory(json['category'] as String),
        iconColor: iconColorForCategory(json['category'] as String),
        isCompleted: json['isCompleted'] as bool? ?? false,
        quantity: json['quantity'] as String?,
      );

  // Helpers (podrían residir en un util)
  static IconData iconForCategory(String c) {
    switch (c) {
      case 'activity':
        return Icons.directions_run;
      case 'nutrition':
        return Icons.eco_outlined;
      case 'sleep':
        return Icons.nightlight_round;
      case 'other':                
        return Icons.self_improvement;
      default:
        return Icons.check_circle;
    }
  }

  static Color bgColorForCategory(String c) {
    switch (c) {
      case 'activity':
        return Colors.teal.shade50;
      case 'nutrition':
        return Colors.green.shade50;
      case 'sleep':
        return const Color(0xFF5956A6).withValues(alpha: .1);
      case 'other':                
        return Colors.orange.shade50;
      default:
        return Colors.grey.shade200;
    }
  }

  static Color iconColorForCategory(String c) {
    switch (c) {
      case 'activity':
        return Colors.teal;
      case 'nutrition':
        return Colors.green;
      case 'sleep':
        return const Color(0xFF5956A6);
      case 'other':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
