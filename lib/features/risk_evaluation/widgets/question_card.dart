// lib/features/risk_evaluation/widgets/question_card.dart

import 'package:flutter/material.dart';
import 'package:gluco_scan/utils/constants/colors.dart';

class QuestionCard extends StatelessWidget {
  final String question;
  final List<String> options;
  final int selected;
  final ValueChanged<int>? onSelected;
  final String? tooltip;

  const QuestionCard({
    super.key,
    required this.question,
    required this.options,
    required this.selected,
    this.onSelected,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pregunta + tooltip
            Row(
              children: [
                Expanded(
                  child: Text(
                    question,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (tooltip != null)
                  Tooltip(
                    message: tooltip!,
                    child: const Icon(Icons.info_outline, size: 16, color: Colors.grey),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            // Opciones
            Row(
              children: List.generate(options.length, (i) {
                final isSel = selected == i;
                return Expanded(
                  child: GestureDetector(
                    onTap: onSelected == null ? null : () => onSelected!(i),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: isSel ? LColors.primary : Colors.transparent,
                        border: Border.all(
                          color: isSel ? LColors.primary : Colors.grey.shade400,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        options[i],
                        style: TextStyle(
                          color: isSel ? Colors.white : Colors.black87,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
