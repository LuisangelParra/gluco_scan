// lib/features/dashboard/controllers/dashboard_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/features/dashboard/widgets/add_data_dialog.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();
  // Rx para que GetX escuche cambios
  final glucose = RxnDouble();
  final insulin = RxnDouble();
  final heartRate = RxnDouble();

  /// Abre el diálogo para añadir datos
  Future<void> showAddDataDialog(BuildContext context) async {
    final gCtrl = TextEditingController(text: glucose.value?.toString());
    final iCtrl = TextEditingController(text: insulin.value?.toString());
    final hCtrl = TextEditingController(text: heartRate.value?.toString());

    await Get.dialog(
      AddDataDialog(
        gCtrl: gCtrl,
        iCtrl: iCtrl,
        hCtrl: hCtrl,
        onSave: () {
          glucose.value = double.tryParse(gCtrl.text);
          insulin.value = double.tryParse(iCtrl.text);
          heartRate.value = double.tryParse(hCtrl.text);
          Get.back();
        },
      ),
    );
  }

  /// Calcula el progreso promedio normalizado (0.0-1.0)
  double get progress {
    final g = glucose.value ?? 0;
    final i = insulin.value ?? 0;
    final h = heartRate.value ?? 0;
    return ((g / 10) + (i / 200) + (h / 120)) / 3;
  }
}
