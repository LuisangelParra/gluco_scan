// lib/features/dashboard/controllers/dashboard_controller.dart
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gluco_scan/data/repositories/dashboard/measurement_repository.dart';
import 'package:gluco_scan/features/dashboard/models/measurement.dart';
import 'package:gluco_scan/features/dashboard/widgets/add_data_dialog.dart';
import 'package:gluco_scan/utils/constants/colors.dart';

class DashboardController extends GetxController {
  final glucose               = RxnDouble();
  final insulin               = RxnDouble();
  final heartRate             = RxnDouble();
  final lastMeasurementTime   = Rxn<DateTime>();
  final nextMeasurementTime   = Rxn<DateTime>();
  static DashboardController get instance => Get.find();

  @override
  void onInit() {
    super.onInit();
    _loadLast();
  }

  Future<void> _loadLast() async {
    final m = await MeasurementRepository.instance.fetchLast();
    if (m != null) {
      lastMeasurementTime.value = m.timestamp;
      glucose.value             = m.glucose;
      insulin.value             = m.insulin;
      heartRate.value           = m.heartRate;
      nextMeasurementTime.value = m.timestamp.add(const Duration(hours: 4));
    } else {
      nextMeasurementTime.value = DateTime.now();
    }
  }

  bool get canAdd {
    final now  = DateTime.now();
    final next = nextMeasurementTime.value!;
    return now.isAfter(next) || now.isAtSameMomentAs(next);
  }

  Future<void> saveMeasurement(double g, double i, double h) async {
    final now = DateTime.now();
    final m = MeasurementModel(
      timestamp: now,
      glucose: g,
      insulin: i,
      heartRate: h,
    );
    await MeasurementRepository.instance.save(m);

    // actualizar estado local
    lastMeasurementTime.value   = now;
    glucose.value               = g;
    insulin.value               = i;
    heartRate.value             = h;
    nextMeasurementTime.value   = now.add(const Duration(hours: 4));
  }

  /// Llamas a este método desde tu UI,
  /// por ejemplo: `controller.showAddDataDialog(context, backgroundColor: Colors.grey[100]);`
  void showAddDataDialog(BuildContext context, {Color? backgroundColor}) {
    final gCtrl = TextEditingController(text: glucose.value?.toStringAsFixed(1));
    final iCtrl = TextEditingController(text: insulin.value?.toStringAsFixed(0));
    final hCtrl = TextEditingController(text: heartRate.value?.toStringAsFixed(0));

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AddDataDialog(
        gCtrl: gCtrl,
        iCtrl: iCtrl,
        hCtrl: hCtrl,
        backgroundColor: backgroundColor ?? LColors.blueAccent,  // <— color a tu gusto
        onSave: canAdd
            ? () async {
                final g = double.tryParse(gCtrl.text.trim());
                final ii = double.tryParse(iCtrl.text.trim());
                final h = double.tryParse(hCtrl.text.trim());
                if (g == null || ii == null || h == null) return;
                await saveMeasurement(g, ii, h);
                Navigator.of(context).pop();
              }
            : null,
      ),
    );
  }

  /// Progreso promedio normalizado (0.0-1.0)
  double get progress {
    final g = glucose.value ?? 0;
    final i = insulin.value ?? 0;
    final h = heartRate.value ?? 0;
    return ((g / 10) + (i / 200) + (h / 120)) / 3;
  }
}
