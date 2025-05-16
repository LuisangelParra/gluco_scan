// lib/features/risk_evaluation/widgets/risk_recommendations.dart
import 'package:flutter/material.dart';
import 'package:gluco_scan/utils/constants/colors.dart';

class RiskRecommendations extends StatelessWidget {
  final Map<String, dynamic> resultado;
  const RiskRecommendations({required this.resultado, super.key});

  @override
  Widget build(BuildContext context) {
    final prob = ((resultado['probabilidad'] as num?) ?? 0).toDouble().clamp(0.0, 1.0);
    final nivel = prob < 0.33 ? 0 : (prob < 0.66 ? 1 : 2);

    const labels = ['Bajo', 'Moderado', 'Alto'];
    const recommendationBg = [
      Color(0xFFFFD0BE),
      Color(0xFFFFEDC3),
      Color(0xFF676DB1),
    ];
    const recommendationTextColor = [
      Color(0xFFB46242),
      Color(0xFFAE8421),
      LColors.primary,
    ];
    final recommendations = [
      'Sigue manteniendo una alimentación equilibrada y actividad física regular.',
      'Intenta aumentar tu consumo de vegetales y hacer ejercicio al menos 30 min al día.',
      'Consulta a un profesional de la salud para una evaluación más detallada.',
    ];

    return Column(
      children: List.generate(3, (j) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Container(
                width: 120,
                height: 48,
                decoration: BoxDecoration(
                  color: recommendationBg[j],
                  borderRadius: BorderRadius.circular(24),
                ),
                alignment: Alignment.center,
                child: Text(
                  labels[j],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: j == nivel ? Colors.white : recommendationTextColor[j],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  recommendations[j],
                  style: const TextStyle(color: Colors.black87, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
