// lib/features/learning/screens/learning_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/utils/constants/sizes.dart';
import 'package:gluco_scan/routes/routes.dart';

import '../controllers/learning_controller.dart';
import '../widgets/learning_app_bar.dart';
import '../widgets/advice_card.dart';
import '../widgets/category_tab.dart';
import '../widgets/content_card.dart';

class LearningScreen extends StatelessWidget {
  const LearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LearningController()); // inicializa el controller
    final ctrl = Get.find<LearningController>();

    return Scaffold(
      appBar: const LearningAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: LSizes.md,
          vertical: LSizes.lg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Consejos, videos y artículos para cuidar tu salud.',
              style: TextStyle(color: Colors.black87, fontSize: 14),
            ),
            const SizedBox(height: LSizes.lg),

            // Consejo
            const AdviceCard(),
            const SizedBox(height: LSizes.lg),

            // Filtros
            Row(
              children: const [
                CategoryTab(keyName: 'nutrition', label: 'Nutrición'),
                SizedBox(width: LSizes.spaceBtwItems),
                CategoryTab(keyName: 'exercise',  label: 'Ejercicio'),
                SizedBox(width: LSizes.spaceBtwItems),
                CategoryTab(keyName: 'prevention', label: 'Prevención'),
              ],
            ),

            const SizedBox(height: LSizes.lg),

            // Contenido dinámico
            Obx(() => Column(
                  children: ctrl.items
                      .map((i) => ContentCard(i))
                      .toList(),
                )),

            const SizedBox(height: LSizes.lg),

            // CTA al final
            Obx(() {
              final messages = {
                'nutrition': 'Come bien, vive mejor.',
                'exercise': 'Muévete hoy es ganar salud mañana.',
                'prevention': 'Prevenir hoy es cuidar tu futuro.',
              };
              return ElevatedButton.icon(
                onPressed: () => Get.toNamed(LRoutes.profile),
                icon: Icon(ctrl.headerIcon, color: Colors.white),
                label: Text(messages[ctrl.category.value]!,
                    style: const TextStyle(fontSize: 14)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ctrl.headerBgColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(LSizes.borderRadiusMd),
                  ),
                  minimumSize: const Size.fromHeight(56),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
