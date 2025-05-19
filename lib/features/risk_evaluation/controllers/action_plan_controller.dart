// lib/features/risk_evaluation/controllers/action_plan_controller.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/utils/constants/colors.dart';

class ActionPlanController extends GetxController {
  /// Indica si estamos cargando datos de Firestore
  final isLoading = true.obs;

  /// Clave actual: "low", "moderate" o "high"
  final selectedLevel = 'low'.obs;

  /// Mapa de secciones recuperadas de Firestore
  final sections = <String, List<String>>{}.obs;

  /// Etiqueta legible para el nivel
  String get selectedLevelLabel {
    switch (selectedLevel.value) {
      case 'moderate':
        return 'Moderado';
      case 'high':
        return 'Alto';
      default:
        return 'Bajo';
    }
  }

  /// Color asociado al nivel
  Color get selectedLevelColor {
    switch (selectedLevel.value) {
      case 'moderate':
        return LColors.riskMedium;
      case 'high':
        return LColors.riskHigh;
      default:
        return LColors.riskLow;
    }
  }

  @override
  void onInit() {
    super.onInit();
    // 1) Leer argumento que trae el riesgo desde RiskResultScreen
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final riesgo = (args['riesgo_diabetes'] as String?)?.toLowerCase() ?? 'baja';
    switch (riesgo) {
      case 'alta':
      case 'high':
        selectedLevel.value = 'high';
        break;
      case 'moderada':
      case 'moderate':
        selectedLevel.value = 'moderate';
        break;
      default:
        selectedLevel.value = 'low';
    }
    // 2) Cargar las secciones correspondientes
    _loadSections();
  }

  /// Carga desde Firestore la colección action_plans/{low|moderate|high}
  Future<void> _loadSections() async {
    isLoading.value = true;
    try {
      final doc = await FirebaseFirestore.instance
          .collection('action_plans')
          .doc(selectedLevel.value)
          .get();
      if (doc.exists && doc.data() != null) {
        final raw = doc.data()!['sections'] as Map<String, dynamic>;
        sections.value = {
          for (final e in raw.entries) 
            e.key: List<String>.from(e.value as List)
        };
      } else {
        sections.clear();
      }
    } catch (e) {
      sections.clear();
    } finally {
      isLoading.value = false;
    }
  }

  /// Cambia el nivel y recarga las secciones
  void selectLevel(String key) {
    if (selectedLevel.value == key) return;
    selectedLevel.value = key;
    _loadSections();
  }
}
