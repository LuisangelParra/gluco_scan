// lib/features/dashboard/widgets/next_measurement_widget.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:gluco_scan/features/dashboard/controllers/dashboard_controller.dart';
import 'package:gluco_scan/utils/constants/colors.dart';

class NextMeasurementWidget extends StatelessWidget {
  const NextMeasurementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<DashboardController>();
    return Obx(() {
      final last = ctrl.lastMeasurementTime.value;
      final next = ctrl.nextMeasurementTime.value;
      return Row(
        children: [
          if (last != null) ...[
            const Icon(Icons.history, size: 20, color: LColors.darkBlue),
            const SizedBox(width: 4),
            Text('Últ: ${DateFormat.Hm().format(last)}',
                style: const TextStyle(color: LColors.darkBlue)),
            const Spacer(),
          ],
          if (next != null) ...[
            const Icon(Icons.access_time, size: 20, color: LColors.primary),
            const SizedBox(width: 4),
            Text('Próx: ${DateFormat.Hm().format(next)}',
                style: const TextStyle(
                  color: LColors.primary, fontWeight: FontWeight.bold)),
          ],
        ],
      );
    });
  }
}
