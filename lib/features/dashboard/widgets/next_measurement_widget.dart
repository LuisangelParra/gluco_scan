// lib/features/dashboard/widgets/next_measurement_widget.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/features/dashboard/controllers/dashboard_controller.dart';
import 'package:gluco_scan/utils/constants/colors.dart';
import 'package:intl/intl.dart';

class NextMeasurementWidget extends StatelessWidget {
  const NextMeasurementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController ctrl = Get.find();
    return Obx(() {
      final DateTime? last = ctrl.lastMeasurementTime.value;
      final TimeOfDay next = ctrl.nextMeasurement.value;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            // Si ya hay una última medición, la mostramos
            if (last != null) ...[
              const Icon(Icons.history, color: LColors.darkBlue, size: 20),
              const SizedBox(width: 4),
              Text(
                'Últ: ${DateFormat.Hm().format(last)}',
                style: const TextStyle(
                  color: LColors.darkBlue,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
            ],

            // Hora de la próxima medición
            const Icon(Icons.access_time, color: LColors.primary, size: 20),
            const SizedBox(width: 4),
            Text(
              'Próx: ${next.format(context)}',
              style: const TextStyle(
                color: LColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    });
  }
}
