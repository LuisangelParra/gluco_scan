// lib/features/risk_evaluation/controllers/risk_result_controller.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/routes/routes.dart';

class RiskResultController extends GetxController {
  /// El último resultado recuperado de Firestore (o null si no hay).
  final result = Rxn<Map<String, dynamic>>();

  /// Indicador de carga.
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadLastResult();
  }

  Future<void> _loadLastResult() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Si no está logueado, quizás enviamos al login o a la evaluación:
      Get.offNamed(LRoutes.riskEval);
      return;
    }

    try {
      final col = FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .collection('RiskEvaluations')
          .orderBy('timestamp', descending: true)
          .limit(1);

      final snap = await col.get();
      if (snap.docs.isEmpty) {
        // Si no hay historial, vamos a evaluación:
        Get.offNamed(LRoutes.riskEval);
      } else {
        result.value = snap.docs.first.data();
      }
    } catch (e) {
      // En caso de error de lectura, también redirigimos:
      Get.offNamed(LRoutes.riskEval);
    } finally {
      isLoading.value = false;
    }
  }
}
