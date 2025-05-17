// lib/features/dashboard/widgets/daily_intake_section.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/features/dashboard/controllers/dashboard_controller.dart';
import 'package:gluco_scan/features/dashboard/widgets/dashboard_card.dart';
import 'package:gluco_scan/features/dashboard/widgets/section_title.dart';
import 'package:gluco_scan/utils/constants/colors.dart';
import 'package:gluco_scan/utils/constants/sizes.dart';

class DailyIntakeSection extends StatelessWidget {
  const DailyIntakeSection({super.key, required this.dashboardController});
  final DashboardController dashboardController;

  static const double metricCardHeight = 120.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionTitle('Ingresos diarios'),
        const SizedBox(height: LSizes.spaceBtwItems),

        // Botón grande para añadir datos
        Obx(() {
          final now  = DateTime.now();
          final next = dashboardController.nextMeasurementTime.value;
          final can  = next == null || now.isAfter(next);

          return DashboardCard(
            backgroundColor: can
                ? LColors.primary
                : LColors.grey.withValues(alpha: .5),
            icon: Icons.add,
            iconColor: Colors.white,
            title: 'Añade tus datos',
            titleColor: Colors.white,
            onTap: can
              ? () => dashboardController.showAddDataDialog(context)
              : null,
          );
        }),

        const SizedBox(height: LSizes.spaceBtwItems),

        // Fila de métricas todas con la misma altura y sin onTap
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: metricCardHeight,
                child: Obx(() {
                  final g = dashboardController.glucose.value;
                  return DashboardCard(
                    backgroundColor: LColors.accent.withValues(alpha: 0.3),
                    icon: Icons.bloodtype,
                    iconColor: LColors.darkBlue,
                    title: 'Glucosa',
                    titleColor: LColors.darkBlue,
                    subtitle: g != null
                        ? '${g.toStringAsFixed(1)} mmol/L'
                        : '--.-- mmol/L',
                    subtitleColor: LColors.darkBlue.withValues(alpha: 0.7),
                    onTap: null, // deshabilitado
                  );
                }),
              ),
            ),
            const SizedBox(width: LSizes.spaceBtwItems),
            Expanded(
              child: SizedBox(
                height: metricCardHeight,
                child: Obx(() {
                  final i = dashboardController.insulin.value;
                  return DashboardCard(
                    backgroundColor: LColors.blush,
                    icon: Icons.opacity,
                    iconColor: LColors.darkBlue,
                    title: 'Insulina',
                    titleColor: LColors.darkBlue,
                    subtitle: i != null
                        ? '${i.toStringAsFixed(0)} mg/dL'
                        : '--.-- mg/dL',
                    subtitleColor: LColors.darkBlue.withValues(alpha: 0.7),
                    onTap: null, // deshabilitado
                  );
                }),
              ),
            ),
            const SizedBox(width: LSizes.spaceBtwItems),
            Expanded(
              child: SizedBox(
                height: metricCardHeight,
                child: Obx(() {
                  final h = dashboardController.heartRate.value;
                  return DashboardCard(
                    backgroundColor: LColors.mint,
                    icon: Icons.favorite,
                    iconColor: LColors.darkBlue,
                    title: 'Ritmo cardíaco',
                    titleColor: LColors.darkBlue,
                    subtitle: h != null
                        ? '${h.toStringAsFixed(0)} bpm'
                        : '--.-- bpm',
                    subtitleColor: LColors.darkBlue.withValues(alpha: 0.7),
                    onTap: null, // deshabilitado
                  );
                }),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
