// lib/features/risk_evaluation/controllers/risk_evaluation_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/data/repositories/risk_evaluation/risk_evaluation_repository.dart';
import 'package:gluco_scan/features/habit_tracking/controllers/habit_tracking_controller.dart';
import 'package:gluco_scan/routes/routes.dart';

class RiskEvaluationController extends GetxController {
  // Formulario
  final formKey = GlobalKey<FormState>();

  // -- Demográficos
  final ageCategory = 1.obs; // 1–13
  final income      = 1.obs; // 1–8

  // -- Peso / Altura
  final weightCtrl = TextEditingController();
  final heightCtrl = TextEditingController();

  // -- Estado de salud
  final genHealth      = 1.obs; // 1–5
  final mentHealthCtrl = TextEditingController();
  final physHealthCtrl = TextEditingController();

  // -- Antecedentes médicos (binarios 0=no,1=sí)
  final highBP     = 0.obs; // HighBP
  final highChol   = 0.obs; // HighChol
  final cholCheck  = 0.obs; // CholCheck
  final smoker     = 0.obs; // Smoker
  final stroke     = 0.obs; // Stroke
  final diffWalk   = 0.obs; // DiffWalk
  final familyHist = 0.obs; // HeartDiseaseorAttack

  // -- Bebedor empedernido
  final hvyAlcohol = 0.obs; // HvyAlcoholConsump

  // -- Actividad física
  final exerciseCtrl = TextEditingController(); // capturamos un valor pero lo convertimos luego a 0/1

  // UI state
  final isEditable = true.obs;
  final isLoading  = false.obs;

  final _repo = RiskEvaluationRepository();

  @override
  void onClose() {
    weightCtrl.dispose();
    heightCtrl.dispose();
    mentHealthCtrl.dispose();
    physHealthCtrl.dispose();
    exerciseCtrl.dispose();
    super.onClose();
  }

  Future<void> submit() async {
    // 1) Validar formulario
    if (!formKey.currentState!.validate()) return;

    isEditable.value = false;
    isLoading.value  = true;

    // 2) Construir payload acorde a la spec de tu API
    final payload = {
      "GenHlth"              : genHealth.value,
      "MentHlth"             : int.parse(mentHealthCtrl.text.trim()),
      "HighBP"               : highBP.value,
      "DiffWalk"             : diffWalk.value,
      "weight"               : double.parse(weightCtrl.text.trim()),
      "height"               : double.parse(heightCtrl.text.trim()),
      "HighChol"             : highChol.value,
      "Age"                  : ageCategory.value,
      "HeartDiseaseorAttack" : familyHist.value,
      "PhysHlth"             : int.parse(physHealthCtrl.text.trim()),
      "Stroke"               : stroke.value,
      // ACTIVIDAD FÍSICA: binario 0/1
      "PhysActivity"         : (exerciseCtrl.text.trim().isNotEmpty ? 1 : 0),
      "HvyAlcoholConsump"    : hvyAlcohol.value,
      "CholCheck"            : cholCheck.value,
      "Income"               : income.value,
      "Smoker"               : smoker.value,
    };

    try {
      // 3) Llamar al repositorio
      final result = await _repo.predict(payload);
      final riesgo = result['riesgo_diabetes'] as String;
      // **¡Aquí asignamos los hábitos!**
      await HabitTrackingController.instance.assignHabitsForRisk(riesgo);

      // 4) Navegar a resultado
      Get.toNamed(LRoutes.riskResult, arguments: result);
    } catch (e) {
      Get.snackbar("Error", "No se pudo obtener resultado: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
