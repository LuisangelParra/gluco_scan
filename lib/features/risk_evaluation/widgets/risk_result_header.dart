// lib/features/risk_evaluation/widgets/risk_result_header.dart

import 'package:flutter/material.dart';
import 'package:gluco_scan/utils/constants/colors.dart';

class RiskResultHeader extends StatelessWidget implements PreferredSizeWidget {
  const RiskResultHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: LColors.primary,
      elevation: 0,
      title: const Text(
        'Tu nivel de riesgo de Diabetes',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 16);
}
