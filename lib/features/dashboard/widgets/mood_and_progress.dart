// lib/features/dashboard/widgets/mood_and_progress.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../controllers/dashboard_controller.dart';

class MoodAndProgress extends StatelessWidget {
  const MoodAndProgress({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = DashboardController.instance;
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: LColors.blush,
          child: const Icon(
            Icons.sentiment_satisfied_outlined,
            size: 48,
            color: LColors.primary,
          ),
        ),
        const SizedBox(height: LSizes.spaceBtwItems),
        Obx(() {
          final prog = ctrl.progress.clamp(0.0, 1.0);
          return Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: prog,
                  minHeight: 12,
                  backgroundColor: LColors.lavenderLight,
                  valueColor: const AlwaysStoppedAnimation(LColors.primary),
                ),
              ),
              const SizedBox(height: LSizes.sm),
              Text(
                'Tu progreso es de ${(prog * 100).toStringAsFixed(0)}%',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: LSizes.xs),
              const Text('¡Mantén tu progreso al día!'),
            ],
          );
        }),
      ],
    );
  }
}
