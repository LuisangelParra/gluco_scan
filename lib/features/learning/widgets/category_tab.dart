// lib/features/learning/widgets/category_tab.dart

import 'package:flutter/material.dart';

class CategoryTab extends StatelessWidget {
  final String keyName;
  final String label;
  final bool selected;
  final Color selectedColor;
  final VoidCallback onTap;

  const CategoryTab({
    super.key,
    required this.keyName,
    required this.label,
    required this.selected,
    required this.selectedColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: selected ? selectedColor : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: selected ? selectedColor : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}