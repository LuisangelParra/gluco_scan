// lib/features/risk_evaluation/widgets/legend_pill.dart
import 'package:flutter/material.dart';

class LegendRow extends StatelessWidget {
  const LegendRow({super.key});
  @override
  Widget build(BuildContext c) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      _LegendPill('Bajo', Color(0xFFFFD0BE), Color(0xFFB46242)),
      SizedBox(width:8),
      _LegendPill('Moderado', Color(0xFFFFEDC3), Color(0xFFAE8421)),
      SizedBox(width:8),
      _LegendPill('Alto', Color(0xFF676DB1), Colors.white),
    ],
  );
}

class _LegendPill extends StatelessWidget {
  final String label;
  final Color background, text;
  const _LegendPill(this.label, this.background, this.text);
  @override
  Widget build(BuildContext c) => Container(
    padding: const EdgeInsets.symmetric(horizontal:12, vertical:6),
    decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(16)),
    child: Text(label, style: TextStyle(color: text, fontWeight: FontWeight.bold)),
  );
}
