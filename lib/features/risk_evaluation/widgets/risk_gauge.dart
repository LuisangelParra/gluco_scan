// lib/features/risk_evaluation/widgets/risk_gauge.dart
import 'package:flutter/material.dart';
import 'package:gluco_scan/utils/constants/colors.dart';

class RiskGauge extends StatelessWidget {
  final Map<String, dynamic> resultado;
  const RiskGauge({required this.resultado, super.key});

  @override
  Widget build(BuildContext context) {
    final prob = ((resultado['probabilidad'] as num?) ?? 0).toDouble().clamp(0.0, 1.0);
    final nivel = prob < 0.33 ? 0 : (prob < 0.66 ? 1 : 2);
    final gaugeColors = [
      LColors.primary.withAlpha(nivel == 2 ? 255 : 100),
      LColors.cream.withAlpha(nivel == 1 ? 255 : 100),
      LColors.accent.withAlpha(nivel == 0 ? 255 : 100),
    ];

    return SizedBox(
      height: 120,
      child: LayoutBuilder(
        builder: (ctx, box) {
          final w = box.maxWidth;
          final pointerLeft = prob * w;
          return Stack(alignment: Alignment.center, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(3, (i) {
                return Container(
                  width: (w - 32) / 3,
                  height: 80,
                  decoration: BoxDecoration(
                    color: gaugeColors[i],
                    borderRadius: BorderRadius.only(
                      topLeft: i == 0 ? const Radius.circular(40) : Radius.zero,
                      topRight: i == 2 ? const Radius.circular(40) : Radius.zero,
                    ),
                  ),
                );
              }),
            ),
            Positioned(
              left: pointerLeft - 4,
              child: Container(
                width: 8,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ]);
        },
      ),
    );
  }
}
