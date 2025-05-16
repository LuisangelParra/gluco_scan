// lib/features/risk_evaluation/widgets/risk_level_list.dart
import 'package:flutter/material.dart';
import 'package:gluco_scan/utils/constants/colors.dart';

class RiskLevelList extends StatelessWidget {
  final Map<String, dynamic> resultado;
  const RiskLevelList({required this.resultado, super.key});

  @override
  Widget build(BuildContext context) {
    final prob = ((resultado['probabilidad'] as num?) ?? 0).toDouble().clamp(0.0, 1.0);
    final nivel = prob < 0.33 ? 0 : (prob < 0.66 ? 1 : 2);
    const labels = ['Bajo', 'Moderado', 'Alto'];
    final gaugeColors = [
      LColors.primary.withAlpha(nivel == 2 ? 255 : 100),
      LColors.cream.withAlpha(nivel == 1 ? 255 : 100),
      LColors.accent.withAlpha(nivel == 0 ? 255 : 100),
    ];
    final descriptions = [
      '¡Bien hecho! Tu riesgo es bajo, sigue manteniendo hábitos saludables.',
      'Tu riesgo es moderado. Puedes hacer cambios para mejorar tu salud.',
      'Tienes un alto riesgo de diabetes. Es importante tomar medidas pronto.',
    ];

    return Column(
      children: List.generate(3, (i) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Container(width: 24, height: 24, decoration: BoxDecoration(color: gaugeColors[i], shape: BoxShape.circle)),
              const SizedBox(width: 12),
              SizedBox(
                width: 100,
                child: Text(labels[i], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: i == nivel
                    ? Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: LColors.lavenderLight, borderRadius: BorderRadius.circular(12)),
                        child: Text(descriptions[i], style: const TextStyle(color: Colors.black87, fontSize: 12)),
                      )
                    : Text(descriptions[i], style: const TextStyle(color: Colors.black87)),
              ),
            ],
          ),
        );
      }),
    );
  }
}
