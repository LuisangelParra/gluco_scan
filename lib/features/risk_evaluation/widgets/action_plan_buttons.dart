// lib/features/risk_evaluation/widgets/action_plan_buttons.dart

import 'package:flutter/material.dart';

class ActionPlanButtons extends StatelessWidget {
  final VoidCallback onStart;
  final VoidCallback onBack;
  final Color       primaryColor;

  const ActionPlanButtons({
    Key? key,
    required this.onStart,
    required this.onBack,
    required this.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: onStart,
            child: const Text('Iniciar seguimiento'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: primaryColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: onBack,
            child: Text('Volver a resultados',
              style: TextStyle(color: primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
