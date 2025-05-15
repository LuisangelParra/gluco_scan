// lib/features/dashboard/screens/dashboard.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/features/dashboard/controllers/dashboard_controller.dart';
import 'package:gluco_scan/features/dashboard/widgets/dashboard_header.dart';
import 'package:gluco_scan/features/dashboard/widgets/mood_and_progress.dart';
import 'package:gluco_scan/features/dashboard/widgets/section_title.dart';
import 'package:gluco_scan/features/dashboard/widgets/dashboard_card.dart';
import 'package:gluco_scan/features/personalization/controllers/user_controller.dart';
import 'package:gluco_scan/routes/routes.dart';


import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    final dashboardController = Get.put(DashboardController());

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Obx(() {
          final name = userController.user.value.name;
          return DashboardHeader(
            userName: name.isNotEmpty ? name : 'Usuario',
          );
        }),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: LSizes.lg,
          horizontal: LSizes.md,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MoodAndProgress(),
            const SizedBox(height: LSizes.lg),

            // Ingresos diarios
            const SectionTitle('Ingresos diarios'),
            const SizedBox(height: LSizes.spaceBtwItems),
            DashboardCard(
              backgroundColor: LColors.primary,
              icon: Icons.add,
              iconColor: Colors.white,
              title: 'Añade tus datos',
              titleColor: Colors.white,
              onTap: () => dashboardController.showAddDataDialog(context),
            ),
            const SizedBox(height: LSizes.spaceBtwItems),
            Row(
              children: [
                Expanded(
                  child: Obx(() => DashboardCard(
                        backgroundColor: LColors.accent.withValues(alpha: 0.3),
                        icon: Icons.bloodtype,
                        iconColor: LColors.darkBlue,
                        title: 'Glucosa',
                        titleColor: LColors.darkBlue,
                        subtitle: dashboardController.glucose.value != null
                            ? '${dashboardController.glucose.value!.toStringAsFixed(1)} mmol/L'
                            : '--.-- mmol/L',
                        subtitleColor:
                            LColors.darkBlue.withValues(alpha: 0.7),
                        onTap: () => dashboardController.showAddDataDialog(context),
                      )),
                ),
                const SizedBox(width: LSizes.spaceBtwItems),
                Expanded(
                  child: Obx(() => DashboardCard(
                        backgroundColor: LColors.blush,
                        icon: Icons.opacity,
                        iconColor: LColors.darkBlue,
                        title: 'Insulina',
                        titleColor: LColors.darkBlue,
                        subtitle: dashboardController.insulin.value != null
                            ? '${dashboardController.insulin.value!.toStringAsFixed(0)} mg/dL'
                            : '--.-- mg/dL',
                        subtitleColor:
                            LColors.darkBlue.withValues(alpha: 0.7),
                        onTap: () => dashboardController.showAddDataDialog(context),
                      )),
                ),
                const SizedBox(width: LSizes.spaceBtwItems),
                Expanded(
                  child: Obx(() => DashboardCard(
                        backgroundColor: LColors.mint,
                        icon: Icons.favorite,
                        iconColor: Colors.white,
                        title: 'Ritmo cardíaco',
                        titleColor: Colors.white,
                        subtitle: dashboardController.heartRate.value != null
                            ? '${dashboardController.heartRate.value!.toStringAsFixed(0)} bpm'
                            : '--.-- bpm',
                        subtitleColor: Colors.white70,
                        onTap: () => dashboardController.showAddDataDialog(context),
                      )),
                ),
              ],
            ),

            const SizedBox(height: LSizes.lg),
            // Control y monitoreo
            const SectionTitle('Control y monitoreo'),
            const SizedBox(height: LSizes.spaceBtwItems),
            GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 0.9,
              crossAxisSpacing: LSizes.spaceBtwItems,
              mainAxisSpacing: LSizes.spaceBtwItems,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                DashboardCard(
                  backgroundColor: LColors.primary,
                  icon: Icons.health_and_safety,
                  iconColor: Colors.white,
                  title: 'Evaluar mi\nriesgo',
                  titleColor: Colors.white,
                  onTap: () => Get.toNamed(LRoutes.riskEval),
                ),
                DashboardCard(
                  backgroundColor: LColors.mint,
                  icon: Icons.show_chart,
                  iconColor: Colors.white,
                  title: 'Nivel de\nriesgo',
                  titleColor: Colors.white,
                  onTap: () => Get.toNamed(LRoutes.riskResult),
                ),
                DashboardCard(
                  backgroundColor: LColors.accent,
                  icon: Icons.event_note,
                  iconColor: Colors.white,
                  title: 'Plan de\nacción',
                  titleColor: Colors.white,
                  onTap: () => Get.toNamed(LRoutes.actionPlan),
                ),
                DashboardCard(
                  backgroundColor: LColors.blush,
                  icon: Icons.track_changes,
                  iconColor: LColors.darkBlue,
                  title: 'Registrar mis\nhábitos',
                  titleColor: LColors.darkBlue,
                  onTap: () => Get.toNamed(LRoutes.habitTracking),
                ),
                DashboardCard(
                  backgroundColor: LColors.lavenderLight,
                  icon: Icons.menu_book,
                  iconColor: LColors.darkBlue,
                  title: 'Aprender sobre\nla diabetes',
                  titleColor: LColors.darkBlue,
                  onTap: () => Get.toNamed(LRoutes.learning),
                ),
                DashboardCard(
                  backgroundColor: LColors.cream,
                  icon: Icons.update,
                  iconColor: LColors.darkBlue,
                  title: 'Actualizar\nmis datos',
                  titleColor: LColors.darkBlue,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
