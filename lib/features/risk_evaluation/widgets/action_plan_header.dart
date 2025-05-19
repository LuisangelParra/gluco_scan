// lib/features/risk_evaluation/widgets/action_plan_header.dart

import 'package:flutter/material.dart';
class ActionPlanHeader extends StatelessWidget implements PreferredSizeWidget {
  final String riskLevel;
  final Color  backgroundColor;

  const ActionPlanHeader({
    super.key,
    required this.riskLevel,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'Plan de acción: $riskLevel',
        style: const TextStyle(color: Colors.white),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 24);
}
