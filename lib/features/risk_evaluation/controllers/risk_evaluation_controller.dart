// lib/features/risk_evaluation/controllers/risk_evaluation_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/data/repositories/risk_evaluation/risk_evaluation_repository.dart';
import 'package:gluco_scan/routes/routes.dart';

class RiskEvaluationController extends GetxController {
  final formKey       = GlobalKey<FormState>();
  final ageCtrl       = TextEditingController();
  final weightCtrl    = TextEditingController();
  final heightCtrl    = TextEditingController();
  final exerciseCtrl  = TextEditingController();
  final gender        = Rxn<String>();
  final fruitVeg      = 0.obs;
  final tobaccoAlc    = 0.obs;
  final familyHist    = 1.obs;
  final isEditable    = true.obs;
  final isLoading     = false.obs;

  final _repo = RiskEvaluationRepository();

  @override
  void onClose() {
    ageCtrl.dispose();
    weightCtrl.dispose();
    heightCtrl.dispose();
    exerciseCtrl.dispose();
    super.onClose();
  }

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;
    isEditable.value = false;
    isLoading.value  = true;

    final payload = {
      "weight": double.tryParse(weightCtrl.text) ?? 70.0,
      "height": double.tryParse(heightCtrl.text) ?? 170.0,
      "PhysActivity": exerciseCtrl.text.trim().isNotEmpty ? 1 : 0,
      "HvyAlcoholConsump": tobaccoAlc.value,
      "Smoker": tobaccoAlc.value,
      "HeartDiseaseorAttack": familyHist.value,
      // ... añade aquí el resto de campos que necesites
    };

    try {
      final result = await _repo.predict(payload);
      Get.toNamed(LRoutes.riskResult, arguments: result);
    } catch (e) {
      Get.snackbar("Error", "No se pudo obtener resultado: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
