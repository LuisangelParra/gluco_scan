// lib/features/learning/screens/learning_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/routes/routes.dart';
import '../../../utils/constants/sizes.dart';
import '../controllers/learning_controller.dart';
import '../widgets/learning_app_bar.dart';
import '../widgets/advice_card.dart';
import '../widgets/category_tab.dart';
import '../widgets/content_card.dart';

class LearningScreen extends StatelessWidget {
  const LearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(LearningController());

    return Scaffold(
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
            const Text(
              'Consejos, videos y artículos para cuidar tu salud.',
              style: TextStyle(color: Colors.black87, fontSize: 14),
            ),
            const SizedBox(height: LSizes.lg),

            // Advice
            Obx(() => AdviceCard(
              tip: ctrl.advice.value,
              backgroundColor: ctrl.headerBgColor,
              iconColor: Colors.white,
            )),
            const SizedBox(height: LSizes.lg),

            // Category tabs
            Obx(() => Row(
              children: [
                CategoryTab(
                  keyName: 'nutrition',
                  label: 'Nutrición',
                  selected: ctrl.category.value=='nutrition',
                  selectedColor: ctrl.headerBgColor,
                  onTap: ()=>ctrl.category.value='nutrition',
                ),
                const SizedBox(width: LSizes.spaceBtwItems),
                CategoryTab(
                  keyName: 'exercise',
                  label: 'Ejercicio',
                  selected: ctrl.category.value=='exercise',
                  selectedColor: ctrl.headerBgColor,
                  onTap: ()=>ctrl.category.value='exercise',
                ),
                const SizedBox(width: LSizes.spaceBtwItems),
                CategoryTab(
                  keyName: 'prevention',
                  label: 'Prevención',
                  selected: ctrl.category.value=='prevention',
                  selectedColor: ctrl.headerBgColor,
                  onTap: ()=>ctrl.category.value='prevention',
                ),
              ],
            )),
            const SizedBox(height: LSizes.lg),

            // Content cards
            Obx(() {
              if (ctrl.items.isEmpty) {
                return const Center(child: Text("No hay contenido disponible."));
              }
              return Column(
                children: ctrl.items.map((i) => ContentCard(
                  item: i,
                  categoryColor: ctrl.headerBgColor,
                )).toList(),
              );
            }),

            const SizedBox(height: LSizes.lg),

            // CTA
            Obx(() => ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(ctrl.headerIcon, color: Colors.white),
              label: Text(ctrl.ctaText, style: const TextStyle(fontSize: 14)),
              style: ElevatedButton.styleFrom(
                backgroundColor: ctrl.headerBgColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(LSizes.borderRadiusMd),
                ),
                minimumSize: const Size.fromHeight(56),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
