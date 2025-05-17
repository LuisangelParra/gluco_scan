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

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionTitle('Ingresos diarios'),
        const SizedBox(height: LSizes.spaceBtwItems),

        // Botón grande para agregar
        DashboardCard(
          backgroundColor: LColors.primary,
          icon: Icons.add,
          iconColor: Colors.white,
          title: 'Añade tus datos',
          titleColor: Colors.white,
          onTap: () => dashboardController.showAddDataDialog(context),
        ),

        const SizedBox(height: LSizes.spaceBtwItems),

        // Fila de métricas
        Row(
          children: [
            Expanded(
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
                  onTap: () => dashboardController.showAddDataDialog(context),
                );
              }),
            ),
            const SizedBox(width: LSizes.spaceBtwItems),
            Expanded(
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
                  onTap: () => dashboardController.showAddDataDialog(context),
                );
              }),
            ),
            const SizedBox(width: LSizes.spaceBtwItems),
            Expanded(
              child: Obx(() {
                final h = dashboardController.heartRate.value;
                return DashboardCard(
                  backgroundColor: LColors.mint,
                  icon: Icons.favorite,
                  iconColor: Colors.white,
                  title: 'Ritmo cardíaco',
                  titleColor: Colors.white,
                  subtitle: h != null
                      ? '${h.toStringAsFixed(0)} bpm'
                      : '--.-- bpm',
                  subtitleColor: Colors.white70,
                  onTap: () => dashboardController.showAddDataDialog(context),
                );
              }),
            ),
          ],
        ),
      ],
    );
  }
}
