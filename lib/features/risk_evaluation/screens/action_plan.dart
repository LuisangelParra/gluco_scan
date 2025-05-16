// lib/features/risk_evaluation/screens/action_plan_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/utils/constants/colors.dart';
import '../widgets/action_plan_header.dart';
import '../widgets/legend_pill.dart';
import '../widgets/category_section.dart';
import '../widgets/action_plan_buttons.dart';

class ActionPlanScreen extends StatelessWidget {
  const ActionPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final resultado = Get.arguments as Map<String, dynamic>? ?? {};
    final String clasificacion = resultado['clasificacion'] ?? 'Desconocido';

    // El header calcula color y texto según clasificación
    return Scaffold(
      backgroundColor: LColors.white,
      appBar: ActionPlanHeader(clasificacion: clasificacion),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Intro text + posible alerta para alto riesgo
            CategorySection.intro(clasificacion: clasificacion),
            const SizedBox(height: 24),

            // Leyenda de colores
            const LegendRow(),

            const SizedBox(height: 24),

            // Secciones de recomendaciones
            CategorySection.food(),
            const SizedBox(height: 24),
            CategorySection.exercise(),
            if (clasificacion == 'Moderado' || clasificacion == 'Alto') ...[
              const SizedBox(height: 24),
              CategorySection.stress(),
            ],
            if (clasificacion == 'Alto') ...[
              const SizedBox(height: 24),
              CategorySection.sleep(),
            ],

            const SizedBox(height: 32),

            // Botones de acción
            const ActionPlanButtons(),
          ],
        ),
      ),
    );
  }
}
