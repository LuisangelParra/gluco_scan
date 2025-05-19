// lib/features/risk_evaluation/widgets/legend_row.dart

import 'package:flutter/material.dart';
import 'package:gluco_scan/utils/constants/colors.dart';

class LegendRow extends StatelessWidget {
  final Color selectedColor;
  const LegendRow({super.key, required this.selectedColor});

  @override
  Widget build(BuildContext context) {
    Widget pill(String label, Color color) {
      final isSel = color == selectedColor;
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSel ? color : color.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        pill('Bajo',     LColors.riskLow),
        pill('Moderado', LColors.riskMedium),
        pill('Alto',     LColors.riskHigh),
      ],
    );
  }
}
