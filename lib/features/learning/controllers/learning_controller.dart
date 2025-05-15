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
    // Carga inicial
    _loadAll();
    // Cuando cambie la categoría, recarga
    ever(category, (_) => _loadAll());
  }

  Future<void> _loadAll() async {
    final cat = category.value;
    advice.value = await _service.fetchAdvice(cat);
    items.value = await _service.fetchContent(cat);
  }

  Color get headerBgColor => _service.headerColor(category.value);
  IconData get headerIcon => _service.headerIcon(category.value);
}
