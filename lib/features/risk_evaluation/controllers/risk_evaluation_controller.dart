// lib/features/risk_evaluation/controllers/risk_evaluation_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/data/repositories/risk_evaluation/risk_evaluation_repository.dart';
import 'package:gluco_scan/features/habit_tracking/controllers/habit_tracking_controller.dart';
import 'package:gluco_scan/routes/routes.dart';

class RiskEvaluationController extends GetxController {
  /// Clave del formulario
  final formKey = GlobalKey<FormState>();

  // --- Demográficos (nuevos rangos según FastAPI) ---
  final ageGroup   = 1.obs; // 1–13
  final education  = 1.obs; // 1–6
  final income     = 1.obs; // 1–11

  // --- Peso / Altura ---
  final weightCtrl = TextEditingController();
  final heightCtrl = TextEditingController();

  // --- Salud general y días malos ---
  final genHealth      = 1.obs; // 1–5
  final mentHealthCtrl = TextEditingController(); // 0–30
  final physHealthCtrl = TextEditingController(); // 0–30

  // --- Antecedentes binarios ---
  final highBP        = 0.obs; // 0/1
  final highChol      = 0.obs; // 0/1
  final smoker        = 0.obs; // 0/1
  final stroke        = 0.obs; // 0/1
  final diffWalk      = 0.obs; // 0/1
  final familyHist    = 0.obs; // HeartDiseaseorAttack 0/1
  final hvyAlcohol    = 0.obs; // HvyAlcoholConsump 0/1

  // --- Actividad física en últimos 30 días (binario) ---
  //final exerciseCtrl  = TextEditingController(); // '' o '1'
  final physActivity = 0.obs;

  // --- UI state ---
  final isEditable = true.obs;
  final isLoading  = false.obs;

  final _repo = RiskEvaluationRepository();

  @override
  void onClose() {
    weightCtrl.dispose();
    heightCtrl.dispose();
    mentHealthCtrl.dispose();
    physHealthCtrl.dispose();
    super.onClose();
  }

  Future<void> submit() async {
    // 1) Validar el form
    if (!formKey.currentState!.validate()) return;

    isEditable.value = false;
    isLoading.value  = true;

    // 2) Armar payload según tu FastAPI
    final payload = {
      "GenHlth"             : genHealth.value,
      "MentHlth"            : int.parse(mentHealthCtrl.text.trim()),
      "HighBP"              : highBP.value,
      "HighChol"            : highChol.value,
      "Smoker"              : smoker.value,
      "Stroke"              : stroke.value,
      "HeartDiseaseorAttack": familyHist.value,
      "PhysActivity"        : physActivity.value, 
      "HvyAlcoholConsump"   : hvyAlcohol.value,
      "DiffWalk"            : diffWalk.value,
      "PhysHlth"            : int.parse(physHealthCtrl.text.trim()),
      "AgeGroup"            : ageGroup.value,
      "Education"           : education.value,
      "Income"              : income.value,
      "weight"              : double.parse(weightCtrl.text.trim()),
      "height"              : double.parse(heightCtrl.text.trim()),
    };

    try {
      // 3) Llamada a la API
      final result = await _repo.predict(payload);
      final riesgo = result['riesgo_diabetes'] as String;

      // 4) Instanciar/recuperar controller de hábitos y asignar plantillas
      Get.put(HabitTrackingController());
      await HabitTrackingController.instance
          .assignHabitsForRisk(riesgo);

      // 5) Navegar a pantalla de resultado
      Get.toNamed(
        LRoutes.riskResult,
        arguments: result,
      );
    } catch (e) {
      Get.snackbar('Error', 'No se pudo obtener resultado: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
