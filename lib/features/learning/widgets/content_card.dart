// lib/features/learning/widgets/content_card.dart

import 'package:flutter/material.dart';
import 'package:gluco_scan/features/learning/models/content_item.dart';

class ContentCard extends StatelessWidget {
  final ContentItem item;
  final Color categoryColor;

  const ContentCard({
    super.key,
    required this.item,
    required this.categoryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      child: ListTile(
        leading: Image.network(
          item.imageUrl,
          width: 60,
          fit: BoxFit.cover,
        ),
        title: Text(
          item.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(item.type),
        trailing: Icon(Icons.chevron_right, color: categoryColor),
        onTap: () {
          // navegar a la URL / detalle
        },
      ),
    );
  }
}
