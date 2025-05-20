// lib/features/learning/controllers/learning_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/features/learning/models/content_item.dart';
import 'package:gluco_scan/features/learning/services/learning_service.dart';

class LearningController extends GetxController {
  final _service = LearningService();

  /// Categoría seleccionada
  final category = 'nutrition'.obs;

  /// Contenido (artículos/videos)
  final items = <ContentItem>[].obs;

  /// Texto de consejo
  final advice = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadAll();
    ever(category, (_) => _loadAll());
  }

  Future<void> _loadAll() async {
    final cat = category.value;
    advice.value = await _service.fetchAdvice(cat);
    items.value = await _service.fetchContent(cat);
  }

  // Título dinámico del AppBar
  String get headerTitle {
    switch (category.value) {
      case 'nutrition':
        return 'Aprende sobre la diabetes';
      case 'exercise':
        return 'Aprende sobre la diabetes';
      default:
        return 'Aprende sobre la diabetes';
    }
  }

  // Colores e ícono para AppBar y botones CTA
  Color get headerBgColor => _service.headerColor(category.value);
  IconData get headerIcon => _service.headerIcon(category.value);

  // Color de iconos en AdviceCard (ligero contraste)
  Color get headerIconColor =>
      headerBgColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;

  // Texto CTA final según categoría
  String get ctaText {
    switch (category.value) {
      case 'nutrition':
        return 'Come bien, vive mejor.';
      case 'exercise':
        return 'Muévete hoy es ganar salud mañana.';
      case 'prevention':
        return 'Prevenir hoy es cuidar tu futuro.';
      default:
        return '';
    }
  }

  // Color para pestañas seleccionadas
  Color get tabSelectedColor => headerBgColor;

  // Cambiar categoría desde las pestañas
  void changeCategory(String cat) {
    category.value = cat;
  }
}
