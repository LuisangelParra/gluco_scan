// lib/features/learning/widgets/learning_app_bar.dart

import 'package:flutter/material.dart';

class LearningAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final IconData icon;

  const LearningAppBar({
    super.key,
    required this.title,
    required this.backgroundColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(title, style: const TextStyle(color: Colors.white)),
      actions: [ Icon(icon, color: Colors.white) ],
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4),
        child: Container(height: 4, color: Colors.white24),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 4);
}
