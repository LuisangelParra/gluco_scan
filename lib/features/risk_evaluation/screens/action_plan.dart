// lib/features/risk_evaluation/screens/action_plan_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/utils/constants/colors.dart';

import '../controllers/action_plan_controller.dart';
import '../widgets/action_plan_header.dart';
import '../widgets/category_section.dart';
import '../widgets/action_plan_buttons.dart';

class ActionPlanScreen extends StatelessWidget {
  const ActionPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(ActionPlanController());

    return Scaffold(
      backgroundColor: LColors.white,

      // AppBar dinámico según nivel seleccionado
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: Obx(() => ActionPlanHeader(
          riskLevel:    ctrl.selectedLevelLabel,
          backgroundColor: ctrl.selectedLevelColor,
        )),
      ),

      body: Obx(() {
        if (ctrl.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              // ─── Selector de nivel de riesgo ─────────────────────────
              Row(
                children: [
                  _levelButton('Bajo',     'low',      ctrl),
                  const SizedBox(width: 8),
                  _levelButton('Moderado','moderate', ctrl),
                  const SizedBox(width: 8),
                  _levelButton('Alto',     'high',     ctrl),
                ],
              ),
              const SizedBox(height: 24),

              // ─── Secciones dinámicas según Firestore ────────────────
              for (final entry in ctrl.sections.entries) ...[
                CategorySection(
                  title:        entry.key,
                  icon:         _iconForSection(entry.key),
                  items:        entry.value,
                  sectionColor: ctrl.selectedLevelColor.withOpacity(0.1),
                  iconColor:    ctrl.selectedLevelColor,
                ),
                const SizedBox(height: 24),
              ],

              // ─── Botones de acción inferiores ───────────────────────
              ActionPlanButtons(
                primaryColor: ctrl.selectedLevelColor,
                onStart:      () {/* TODO: iniciar seguimiento */},
                onBack:       () => Get.back(),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _levelButton(String label, String key, ActionPlanController ctrl) {
    final isSelected = ctrl.selectedLevel.value == key;
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isSelected ? ctrl.selectedLevelColor : LColors.lightBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        onPressed: () => ctrl.selectLevel(key),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  IconData _iconForSection(String title) {
    switch (title.toLowerCase()) {
      case 'alimentación':      return Icons.local_dining;
      case 'ejercicio':         return Icons.fitness_center;
      case 'manejo del estrés': return Icons.self_improvement;
      case 'hábitos de sueño':  return Icons.hotel;
      default:                  return Icons.check_circle_outline;
    }
  }
}
