// lib/features/risk_evaluation/widgets/legend_pill.dart
import 'package:flutter/material.dart';

class LegendPill extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  const LegendPill({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    super.key,
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

class LegendRow extends StatelessWidget {
  const LegendRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        LegendPill(label: 'Bajo', backgroundColor: Color(0xFFFFD0BE), textColor: Color(0xFFB46242)),
        LegendPill(label: 'Moderado', backgroundColor: Color(0xFFFFEDC3), textColor: Color(0xFFAE8421)),
        LegendPill(label: 'Alto', backgroundColor: Color(0xFF676DB1), textColor: Colors.white),
      ],
    );
  }
}
