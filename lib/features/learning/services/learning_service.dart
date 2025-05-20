// lib/features/learning/services/learning_service.dart
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/content_item.dart';

class LearningService {
  final _col = FirebaseFirestore.instance.collection('learning_content');

  /// Devuelve consejos (texto) según categoría
  Future<String> fetchAdvice(String categoryKey) async {
    final doc = await _col.doc('advice_$categoryKey').get();
    return doc.data()?['tip'] as String? ?? '';
  }

  /// Devuelve la lista de artículos/videos
  Future<List<ContentItem>> fetchContent(String categoryKey) async {
    final snap = await _col
        .where('categoryKey', isEqualTo: categoryKey)
        .orderBy('order', descending: false)
        .get();

    return snap.docs.map((doc) {
      return ContentItem.fromJson(
        doc.data(),
        idFromDoc: doc.id,
      );
    }).toList();
  }

  // Colores e iconos para el AppBar
  Color headerColor(String cat) {
    switch (cat) {
      case 'exercise':   return const Color(0xFF6C5DD3);
      case 'prevention': return const Color(0xFFF8C628);
      case 'nutrition':
      default:            return const Color(0xFF20C3AF);
    }
  }

  IconData headerIcon(String cat) {
    switch (cat) {
      case 'exercise':   return Icons.fitness_center;
      case 'prevention': return Icons.health_and_safety;
      case 'nutrition':
      default:            return Icons.eco;
    }
  }
}
