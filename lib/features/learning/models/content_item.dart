// lib/features/learning/models/content_item.dart

class ContentItem {
  final String id;
  final String title;
  final String type;      // e.g. "Artículo" o "Video"
  final String categoryKey; // e.g. "nutrition", "exercise", "prevention"
  final String imageUrl;
  final String url;       // enlace al artículo o video

  ContentItem({
    required this.id,
    required this.title,
    required this.type,
    required this.categoryKey,
    required this.imageUrl,
    required this.url,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'type': type,
        'categoryKey': categoryKey,
        'imageUrl': imageUrl,
        'url': url,
      };

  /// Ahora acepta un id externo (por ejemplo `doc.id`) y lo usa si
  /// `json['id']` es nulo.
  factory ContentItem.fromJson(
    Map<String, dynamic> json, {
    String? idFromDoc,
  }) {
    final fallbackId = idFromDoc ?? '';
    final rawId      = json['id'];
    final id         = rawId is String && rawId.isNotEmpty
        ? rawId
        : fallbackId;

    return ContentItem(
      id:          id,
      title:       json['title']       as String? ?? '',
      type:        json['type']        as String? ?? '',
      categoryKey: json['categoryKey'] as String? ?? '',
      imageUrl:    json['imageUrl']    as String? ?? '',
      url:         json['url']         as String? ?? '',
    );
  }
}
