import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/utils/constants/colors.dart';
import 'package:gluco_scan/routes/app_routes.dart';

class ActionPlanScreen extends StatelessWidget {
  const ActionPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LColors.white,
      appBar: AppBar(
        backgroundColor: LColors.primary,
        elevation: 0,
        title: const Text(
          'Recomendaciones para ti',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hemos preparado estrategias personalizadas según tu nivel de riesgo. Pequeños cambios pueden marcar la diferencia.',
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 24),
            // Leyenda de colores
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _LegendPill(label: 'Bajo', backgroundColor: Color(0xFFFFD0BE), textColor: Color(0xFFB46242)),
                _LegendPill(label: 'Moderado', backgroundColor: Color(0xFFFFEDC3), textColor: Color(0xFFAE8421)),
                _LegendPill(label: 'Alto', backgroundColor: Color(0xFF676DB1), textColor: Colors.white),
              ],
            ),
            const SizedBox(height: 24),

            // Secciones de categoría
            _CategorySection(
              title: 'Alimentación',
              icon: Icons.local_dining,
              items: const [
                'Mantén una dieta balanceada con frutas, verduras y proteínas saludables.',
                'Reduce el consumo de azúcar y alimentos ultraprocesados.',
                'Consulta a un nutricionista para una dieta personalizada.',
              ],
            ),
            const SizedBox(height: 24),
            _CategorySection(
              title: 'Ejercicio',
              icon: Icons.fitness_center,
              items: const [
                'Sigue con tu rutina de actividad física de al menos 30 min al día.',
                'Aumenta tu actividad a mínimo 5 días a la semana.',
                'Consulta con un especialista antes de iniciar una rutina de ejercicio.',
              ],
            ),
            const SizedBox(height: 24),
            _CategorySection(
              title: 'Manejo del estrés',
              icon: Icons.self_improvement,
              items: const [
                'Practica técnicas de relajación como meditación o respiración profunda.',
                'Reduce la exposición al estrés con pausas activas y momentos de descanso.',
                'Considera apoyo profesional si el estrés está afectando tu bienestar.',
              ],
            ),
            const SizedBox(height: 24),
            _CategorySection(
              title: 'Hábitos de sueño',
              icon: Icons.hotel,
              items: const [
                'Mantén un horario de sueño regular de 7-8 horas.',
                'Evita pantallas antes de dormir y mejora tu higiene del sueño.',
                'Consulta a un especialista si tienes problemas de sueño constantes.',
              ],
            ),
            const SizedBox(height: 32),

            // Botones de acción
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: LColors.mint,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                    onPressed: () {},
                    child: const Text('Iniciar seguimiento'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: LColors.primary),
                      foregroundColor: LColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                    child: const Text('Volver a resultados'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LegendPill extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  const _LegendPill({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(24)),
      child: Text(label, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
    );
  }
}

class _CategorySection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<String> items;
  const _CategorySection({
    required this.title,
    required this.icon,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Body container (items)
          Container(
            margin: const EdgeInsets.only(top: 24),
            width: double.infinity,
            decoration: BoxDecoration(
              color: LColors.lightBackground,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: items.map((text) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.black87, shape: BoxShape.circle)),
                      const SizedBox(width: 8),
                      Expanded(child: Text(text, style: const TextStyle(fontSize: 12, color: Colors.black87))),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          // Title pill positioned overlapping top-right
          Positioned(
            top: 0,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: LColors.mint,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Icon(icon, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}