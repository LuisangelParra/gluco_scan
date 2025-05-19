// lib/features/risk_evaluation/widgets/risk_level_list.dart

import 'package:flutter/material.dart';

// Widget que muestra los niveles de riesgo (Baja, Moderada, Alta)
// coloreados según su nivel y resalta el nivel actual.
class RiskLevelList extends StatelessWidget {
  final Map<String, dynamic> resultado;
  const RiskLevelList({super.key, required this.resultado});

  static const Color _lowColor   = Color(0xFF66BB6A);
  static const Color _midColor   = Color(0xFFFFEE58);
  static const Color _highColor  = Color(0xFFE53935);

  @override
  Widget build(BuildContext context) {
    final riesgo = (resultado['riesgo_diabetes'] as String? ?? '').toLowerCase();
    final labels = ['Baja', 'Moderada', 'Alta'];
    final descriptions = [
      '¡Bien hecho! Tu riesgo es bajo, sigue manteniendo hábitos saludables.',
      'Tu riesgo es moderado. Puedes hacer cambios para mejorar tu salud.',
      'Tienes un alto riesgo de diabetes. Es importante tomar medidas pronto.',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(3, (i) {
        final isCurrent = labels[i].toLowerCase() == riesgo;
        final color = i == 0
            ? _lowColor
            : i == 1
                ? _midColor
                : _highColor;
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: isCurrent
              ? const EdgeInsets.all(12)
              : EdgeInsets.zero,
          decoration: isCurrent
              ? BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                )
              : null,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Bullet coloreado
              Container(
                width: 16,
                height: 16,
                margin: const EdgeInsets.only(top: 4),
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 12),
              // Texto descriptivo
              Expanded(
                child: Text(
                  descriptions[i],
                  style: TextStyle(
                    color: isCurrent ? Colors.black87 : Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
