// lib/features/dashboard/widgets/dashboard_header.dart

import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class DashboardHeader extends StatelessWidget
    implements PreferredSizeWidget {
  final String userName;
  const DashboardHeader({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: LColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(LSizes.cardRadiusLg),
          bottomRight: Radius.circular(LSizes.cardRadiusLg),
        ),
      ),
      padding: const EdgeInsets.only(
        top: 40,
        left: LSizes.lg,
        right: LSizes.lg,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '⭐ Buen día, $userName',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: LSizes.sm),
                const Text(
                  '¡Aquí está tu progreso de salud!',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings, color: Colors.white),
          ),
          const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: LColors.primary),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}
