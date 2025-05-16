// lib/features/risk_evaluation/widgets/category_section.dart
import 'package:flutter/material.dart';
import 'package:gluco_scan/utils/constants/colors.dart';

class CategorySection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<String> items;
  final bool showAlert;
  final String? alertText;

  const CategorySection({
    required this.title,
    required this.icon,
    required this.items,
    this.showAlert = false,
    this.alertText,
    super.key,
  });

  /// Intro + advertencia si es alto riesgo
  factory CategorySection.intro({required String clasificacion}) {
    return CategorySection(
      title: '',
      icon: Icons.warning,
      items: [],
      showAlert: clasificacion == 'Alto',
      alertText: clasificacion == 'Alto'
          ? 'Este nivel de riesgo requiere atención prioritaria. Considera consultar a un profesional de salud.'
          : null,
    );
  }

  static CategorySection food() => const CategorySection(
        title: 'Alimentación',
        icon: Icons.local_dining,
        items: [
          'Mantén una dieta balanceada con frutas, verduras y proteínas saludables.',
          'Reduce el consumo de azúcar y alimentos ultraprocesados.',
          'Consulta a un nutricionista para una dieta personalizada.',
        ],
      );

  static CategorySection exercise() => const CategorySection(
        title: 'Ejercicio',
        icon: Icons.fitness_center,
        items: [
          'Sigue con tu rutina de actividad física de al menos 30 min al día.',
          'Aumenta tu actividad a mínimo 5 días a la semana.',
          'Consulta con un especialista antes de iniciar una rutina de ejercicio.',
        ],
      );

  static CategorySection stress() => const CategorySection(
        title: 'Manejo del estrés',
        icon: Icons.self_improvement,
        items: [
          'Practica técnicas de relajación como meditación o respiración profunda.',
          'Reduce la exposición al estrés con pausas activas y momentos de descanso.',
          'Considera apoyo profesional si el estrés está afectando tu bienestar.',
        ],
      );

  static CategorySection sleep() => const CategorySection(
        title: 'Hábitos de sueño',
        icon: Icons.hotel,
        items: [
          'Mantén un horario de sueño regular de 7-8 horas.',
          'Evita pantallas antes de dormir y mejora tu higiene del sueño.',
          'Consulta a un especialista si tienes problemas de sueño constantes.',
        ],
      );

  @override
  Widget build(BuildContext context) {
    if (title.isEmpty) {
      // Solo advertencia
      return Column(
        children: [
          if (showAlert && alertText != null)
            Row(
              children: [
                const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 32),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    alertText!,
                    style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
        ],
      );
    }
    return _buildSection();
  }

  Widget _buildSection() {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Body
          Container(
            margin: const EdgeInsets.only(top: 24),
            width: double.infinity,
            decoration: BoxDecoration(
              color: LColors.lightBackground,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: items
                  .map((text) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.black87, shape: BoxShape.circle)),
                            const SizedBox(width: 8),
                            Expanded(child: Text(text, style: const TextStyle(fontSize: 12, color: Colors.black87))),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
          // Title pill
          Positioned(
            top: 0,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(color: LColors.mint, borderRadius: BorderRadius.circular(24)),
              child: Row(
                children: [Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), const SizedBox(width: 8), Icon(icon, color: Colors.white)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
