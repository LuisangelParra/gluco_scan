// lib/features/risk_evaluation/widgets/risk_recommendations.dart

import 'package:flutter/material.dart';

// Widget que muestra recomendaciones detalladas,
// con una pastilla de color para cada nivel.
class RiskRecommendations extends StatelessWidget {
  final Map<String, dynamic> resultado;
  const RiskRecommendations({super.key, required this.resultado});

  static const Color _lowColor   = Color(0xFF66BB6A);
  static const Color _midColor   = Color(0xFFFFEE58);
  static const Color _highColor  = Color(0xFFE53935);

  @override
  Widget build(BuildContext context) {
    final labels = ['Baja', 'Moderada', 'Alta'];
    final recs = [
      [
        'Mantén una dieta balanceada con frutas, verduras y proteínas saludables.',
        'Reduce el consumo de azúcar y alimentos ultraprocesados.',
        'Consulta a un nutricionista para una dieta personalizada.',
      ],
      [
        'Sigue con tu rutina de actividad física de al menos 30 min al día.',
        'Aumenta tu actividad a mínimo 5 días a la semana.',
        'Consulta con un especialista antes de iniciar una rutina de ejercicio.',
      ],
      [
        'Practica técnicas de relajación como meditación o respiración profunda.',
        'Reduce la exposición al estrés con pausas activas y momentos de descanso.',
        'Mantén un horario de sueño regular de 7–8 horas.',
      ],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(3, (i) {
        final color = i == 0
            ? _lowColor
            : i == 1
                ? _midColor
                : _highColor;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Pastilla con etiqueta
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  labels[i],
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 12),
              // Lista de recomendaciones
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: recs[i].map((text) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            margin: const EdgeInsets.only(top: 6),
                            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              text,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
