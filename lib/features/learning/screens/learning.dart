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
    // inicializa el controller
    final ctrl = Get.put(LearningController());

    return Scaffold(
      // AppBar usando Obx para refrescar su color/icono
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(() => LearningAppBar(
              title: 'Aprende sobre la diabetes',
              backgroundColor: ctrl.headerBgColor,
              icon: ctrl.headerIcon,
            )),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: LSizes.md,
          vertical: LSizes.lg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subtitle
            const Text(
              'Consejos, videos y artículos para cuidar tu salud.',
              style: TextStyle(color: Colors.black87, fontSize: 14),
            ),
            const SizedBox(height: LSizes.lg),

            // AdviceCard reactivo
            Obx(() => AdviceCard(
                  tip: ctrl.advice.value,
                  backgroundColor: ctrl.headerBgColor,
                  iconColor: Colors.white,
                )),
            const SizedBox(height: LSizes.lg),

            // Selector de categorías centradito
            Center(
              child: Obx(() {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CategoryTab(
                      keyName: 'nutrition',
                      label: 'Nutrición',
                      selected: ctrl.category.value == 'nutrition',
                      selectedColor: ctrl.headerBgColor,
                      onTap: () => ctrl.category.value = 'nutrition',
                    ),
                    const SizedBox(width: LSizes.spaceBtwItems),
                    CategoryTab(
                      keyName: 'exercise',
                      label: 'Ejercicio',
                      selected: ctrl.category.value == 'exercise',
                      selectedColor: ctrl.headerBgColor,
                      onTap: () => ctrl.category.value = 'exercise',
                    ),
                    const SizedBox(width: LSizes.spaceBtwItems),
                    CategoryTab(
                      keyName: 'prevention',
                      label: 'Prevención',
                      selected: ctrl.category.value == 'prevention',
                      selectedColor: ctrl.headerBgColor,
                      onTap: () => ctrl.category.value = 'prevention',
                    ),
                  ],
                );
              }),
            ),
            const SizedBox(height: LSizes.lg),

            // Listado de contenidos
            Obx(() {
              if (ctrl.items.isEmpty) {
                return const Center(child: Text('Cargando…'));
              }
              return Column(
                children: ctrl.items
                    .map((i) => ContentCard(
                          item: i,
                          categoryColor: ctrl.headerBgColor,
                        ))
                    .toList(),
              );
            }),
            const SizedBox(height: LSizes.lg),

            // CTA al final (reactivo)
            Obx(() {
              final messages = {
                'nutrition': 'Come bien, vive mejor.',
                'exercise': 'Muévete hoy es ganar salud mañana.',
                'prevention': 'Prevenir hoy es cuidar tu futuro.',
              };
              return Center(
                child: ElevatedButton.icon(
                  onPressed: () => Get.toNamed(LRoutes.profile),
                  icon: Icon(ctrl.headerIcon, color: Colors.white),
                  label: Text(
                    messages[ctrl.category.value]!,
                    style: const TextStyle(fontSize: 14),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ctrl.headerBgColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(LSizes.borderRadiusMd),
                    ),
                    minimumSize: const Size(200, 48),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
