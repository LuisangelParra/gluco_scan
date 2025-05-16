// lib/features/habit_tracking/widgets/habit_tip_card.dart

import 'package:flutter/material.dart';

class HabitTipCard extends StatelessWidget {
  final String text;
  const HabitTipCard(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFF5956A6).withValues(alpha: .1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.nightlight_round,
                color: Color(0xFF5956A6), size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: 15)),
          ),
        ],
      ),
    );
  }
}
