// lib/features/dashboard/controllers/dashboard_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/data/repositories/dashboard/measurement_repository.dart';
import 'package:gluco_scan/features/dashboard/models/measurement.dart';
import 'package:gluco_scan/features/dashboard/widgets/add_data_dialog.dart';
import 'package:gluco_scan/features/habit_tracking/controllers/habit_tracking_controller.dart';
import 'package:gluco_scan/utils/constants/colors.dart';

class DashboardController extends GetxController {
  // Últimos valores
  final glucose             = RxnDouble();
  final insulin             = RxnDouble();
  final heartRate           = RxnDouble();
  final lastMeasurementTime = Rxn<DateTime>();
  final nextMeasurementTime = Rxn<DateTime>();

  // — Nuevas variables de progreso —
  final dailyMeasurements   = 0.obs;
  final measurementProgress = 0.0.obs; // 0.0–1.0
  final habitProgress       = 0.0.obs; // 0.0–1.0
  static const _measurementGoal = 3;   // meta: 3 mediciones/día

  static DashboardController get instance => Get.put(DashboardController());

  @override
  void onInit() {
    super.onInit();
    _loadLast();
    _updateDailyMeasurements(); // carga inicial
    ever(HabitTrackingController.instance.allHabits, (_) => _updateHabitProgress());
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
    final now = DateTime.now();
    final next = nextMeasurementTime.value;
    if (next == null) {
      // aun no cargó la próxima hora de medición, o es el primer registro:
      return true;
    }
    // true si ya pasó o es igual:
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

    // actualizar local
    lastMeasurementTime.value = now;
    glucose.value             = g;
    insulin.value             = i;
    heartRate.value           = h;
    nextMeasurementTime.value = now.add(const Duration(hours: 4));

    // recalc progress de mediciones
    await _updateDailyMeasurements();
  }

  /// 1) Cuenta y normaliza mediciones desde medianoche
  Future<void> _updateDailyMeasurements() async {
    final now   = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final list  = await MeasurementRepository.instance.fetchSince(start);
    dailyMeasurements.value   = list.length;
    measurementProgress.value = (list.length / _measurementGoal).clamp(0.0, 1.0);
  }

  /// 2) Progreso de hábitos completados
  void _updateHabitProgress() {
    final all = HabitTrackingController.instance.allHabits;
    if (all.isEmpty) {
      habitProgress.value = 0.0;
    } else {
      final done = all.where((h) => h.isCompleted).length;
      habitProgress.value = (done / all.length).clamp(0.0, 1.0);
    }
  }

  /// 3) Progreso global (promedio de mediciones + hábitos)
  double get progress =>
      ((measurementProgress.value + habitProgress.value) / 2);

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
        backgroundColor: backgroundColor ?? LColors.blueAccent,
        onSave: canAdd
            ? () async {
                final g  = double.tryParse(gCtrl.text.trim());
                final ii = double.tryParse(iCtrl.text.trim());
                final h  = double.tryParse(hCtrl.text.trim());
                if (g == null || ii == null || h == null) return;
                await saveMeasurement(g, ii, h);
                Navigator.of(context).pop();
              }
            : null,
      ),
    );
  }
}
