// lib/features/habit_tracking/widgets/habit_tracking_header.dart

import 'package:flutter/material.dart';

class HabitTrackingHeader extends StatelessWidget
    implements PreferredSizeWidget {
  const HabitTrackingHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(96);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Padding en lugar de margin, para que todo quepa en 96px de alto.
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back,
                color: Color(0xFF5956A6), size: 24),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(width: 12),
          // Hacemos que el Column ocupe su altura mínima
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Seguimiento',
                style: TextStyle(
                  color: Color(0xFF5956A6),
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              Text(
                'de hábitos',
                style: TextStyle(
                  color: Color(0xFF5956A6),
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF5956A6).withValues(alpha: .1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.favorite,
              color: Color(0xFF5956A6),
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
