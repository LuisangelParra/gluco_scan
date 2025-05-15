// lib/features/learning/widgets/content_card.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/features/learning/controllers/learning_controller.dart';
import 'package:gluco_scan/features/learning/models/content_item.dart';
import 'package:gluco_scan/utils/constants/colors.dart';
import 'package:gluco_scan/utils/constants/sizes.dart';

class ContentCard extends StatelessWidget {
  final ContentItem item;
  const ContentCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<LearningController>();
    return Container(
      margin: const EdgeInsets.only(bottom: LSizes.lg),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(LSizes.borderRadiusMd),
            child: Image.network(
              item.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 80,
                height: 80,
                color: LColors.lightBackground,
                child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: LSizes.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    color: ctrl.headerBgColor,
                    decoration: TextDecoration.underline,
                    fontSize: 15,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: LSizes.xs),
                Text(
                  item.type,
                  style: TextStyle(
                    color: ctrl.headerBgColor.withValues(alpha: .7),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.star_border, color: ctrl.headerBgColor),
        ],
      ),
    );
  }
}
