// lib/features/learning/models/content_item.dart

class ContentItem {
  final String id;
  final String category;
  final String type;
  final String title;
  final String description;
  final String imageUrl;
  final String url;

  ContentItem({
    required this.id,
    required this.category,
    required this.type,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.url,
  });

  factory ContentItem.fromJson(String id, Map<String, dynamic> json) {
    return ContentItem(
      id: id,
      category: json['category'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      url: json['url'] as String,
    );
  }


}
