// lib/features/learning/widgets/advice_card.dart

import 'package:flutter/material.dart';

class AdviceCard extends StatelessWidget {
  final String tip;
  final Color backgroundColor;
  final Color iconColor;

  const AdviceCard({
    super.key,
    required this.tip,
    required this.backgroundColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(Icons.lightbulb, size: 28, color: iconColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              tip,
              style: TextStyle(
                color: iconColor.withOpacity(0.9),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
