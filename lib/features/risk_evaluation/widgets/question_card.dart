// lib/features/risk_evaluation/widgets/question_card.dart
import 'package:flutter/material.dart';

typedef OnSelected = void Function(int);

class QuestionCard extends StatelessWidget {
  final String question;
  final List<String> options;
  final int selected;
  final OnSelected? onSelected;

  const QuestionCard({
    super.key,
    required this.question,
    required this.options,
    required this.selected,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question, style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: options.asMap().entries.map((e) {
            final isSel = e.key == selected;
            final bgColors = [
              const Color(0xFFFFD0BE),
              const Color(0xFFFFEDC3),
              const Color(0xFFAEEDE4),
            ];
            final selColors = [
              const Color(0xFFB46242),
              const Color(0xFFAE8421),
              const Color(0xFF167B6B),
            ];
            return ChoiceChip(
              label: Text(e.value,
                  style: TextStyle(color: isSel ? Colors.white : selColors[e.key])),
              selected: isSel,
              onSelected: onSelected == null ? null : (_) => onSelected!(e.key),
              backgroundColor: bgColors[e.key],
              selectedColor: selColors[e.key],
              shape: const StadiumBorder(),
            );
          }).toList(),
        ),
      ],
    );
  }
}
