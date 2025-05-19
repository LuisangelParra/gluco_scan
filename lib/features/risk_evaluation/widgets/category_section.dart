// lib/features/risk_evaluation/widgets/category_section.dart

import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  final String    title;
  final IconData  icon;
  final List<String> items;
  final Color     sectionColor;
  final Color     iconColor;

  const CategorySection({
    Key? key,
    required this.title,
    required this.icon,
    required this.items,
    required this.sectionColor,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // barra superior con icono y título
        Container(
          decoration: BoxDecoration(
            color: sectionColor,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            children: [
              Icon(icon, color: iconColor),
              const SizedBox(width: 8),
              Text(title,
                style: TextStyle(
                  color: iconColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // lista de viñetas
        ...items.map((text) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Container(
                width: 8, height: 8,
                decoration: BoxDecoration(
                  color: iconColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(child: Text(text)),
            ],
          ),
        )),
      ],
    );
  }
}
