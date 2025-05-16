// lib/features/risk_evaluation/widgets/action_plan_header.dart
import 'package:flutter/material.dart';
import 'package:gluco_scan/utils/constants/colors.dart';

class ActionPlanHeader extends StatelessWidget implements PreferredSizeWidget {
  final String clasificacion;
  const ActionPlanHeader({required this.clasificacion, super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 16);

  @override
  Widget build(BuildContext context) {
    late Color bg;

    switch (clasificacion) {
      case 'Bajo':
        bg = const Color(0xFFFFD0BE);
        break;
      case 'Moderado':
        bg = const Color(0xFFFFEDC3);
        break;
      case 'Alto':
        bg = const Color(0xFF676DB1);
        break;
      default:
        bg = LColors.primary;
    }

    return AppBar(
      backgroundColor: bg,
      elevation: 0,
      title: const Text(
        'Recomendaciones para ti',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
    );
  }
}
