// lib/features/learning/models/content_item.dart

class ContentItem {
  final String imageUrl;
  final String title;
  final String type; // “Artículo” o “Video”

  ContentItem({
    required this.imageUrl,
    required this.title,
    required this.type,
  });

  factory ContentItem.fromJson(Map<String, dynamic> json) => ContentItem(
        imageUrl: json['image'] as String,
        title: json['title'] as String,
        type: json['type'] as String,
      );
}
