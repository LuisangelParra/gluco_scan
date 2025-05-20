// lib/features/learning/services/learning_service.dart
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/content_item.dart';

class LearningService {
  final _db = FirebaseFirestore.instance;

  /// Trae el tip breve para la cabecera
  Future<String> fetchAdvice(String category) async {
    final snap = await _db
      .collection('learning_tips')
      .where('category', isEqualTo: category)
      .limit(1)
      .get();
    if (snap.docs.isEmpty) return '';
    return snap.docs.first.data()['tip'] as String;
  }

  /// Trae todos los artículos/videos de una categoría
  Future<List<ContentItem>> fetchContent(String category) async {
    final snap = await _db
      .collection('learning_content')
      .where('category', isEqualTo: category)
      .orderBy('title') // u otro campo si prefieres
      .get();
    return snap.docs
      .map((d) => ContentItem.fromJson(d.id, d.data()))
      .toList();
  }

  /// Colores e iconos para cada pestaña
  Color headerColor(String category) {
    switch (category) {
      case 'nutrition':  return const Color(0xFF00BFA6);
      case 'exercise':   return const Color(0xFF6665A9);
      case 'prevention': return const Color(0xFFF9A825);
      default:           return Colors.grey;
    }
  }
  IconData headerIcon(String category) {
    switch (category) {
      case 'nutrition':  return Icons.eco_outlined;
      case 'exercise':   return Icons.fitness_center;
      case 'prevention': return Icons.shield_outlined;
      default:           return Icons.lightbulb_outline;
    }
  }
}
