// lib/features/learning/services/learning_service.dart
import 'package:flutter/material.dart';
import 'package:gluco_scan/features/learning/models/content_item.dart';

/// En producción aquí harías peticiones HTTP a tu backend / headless CMS.
class LearningService {
  /// Mock: simula delay y devuelve lista según categoría.
  Future<List<ContentItem>> fetchContent(String category) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // estos datos podrían provenir de Firebase, Strapi, Contentful, NewsAPI, etc.
    final raw = _mockData[category]!;
    return raw.map((m) => ContentItem.fromJson(m)).toList();
  }

  /// Mock de consejo por categoría
  Future<String> fetchAdvice(String category) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _mockAdvice[category]!;
  }

  /// Colores e íconos por categoría
  Color headerColor(String category) {
    switch (category) {
      case 'nutrition': return const Color(0xFFAEEDE4);
      case 'exercise': return const Color(0xFFFFD0BE);
      case 'prevention': return const Color(0xFFFFEDC3);
      default: return const Color(0xFFE0E0E0);
    }
  }

  IconData headerIcon(String category) {
    switch (category) {
      case 'nutrition': return Icons.restaurant_menu;
      case 'exercise': return Icons.fitness_center;
      case 'prevention': return Icons.shield;
      default: return Icons.info;
    }
  }

  final Map<String, String> _mockAdvice = {
    'nutrition': 'Tomar agua con frecuencia ayuda a controlar los niveles de azúcar.',
    'exercise': '30 minutos de actividad física al día reducen el riesgo de enfermedades crónicas.',
    'prevention': 'Hasta el 80% de enfermedades crónicas se pueden prevenir.',
  };

  final Map<String, List<Map<String, String>>> _mockData = {
    'nutrition': [
      {
        'image': 'https://picsum.photos/80?random=10',
        'title': '¿Cuál es el mejor desayuno para diabéticos?',
        'type': 'Artículo',
      },
      {
        'image': 'https://picsum.photos/80?random=11',
        'title': 'Alimentos que ayudan a controlar el azúcar',
        'type': 'Video',
      },
      {
        'image': 'https://picsum.photos/80?random=12',
        'title': 'Leyendo las etiquetas de los alimentos',
        'type': 'Artículo',
      },
    ],
    'exercise': [
      {
        'image': 'https://picsum.photos/80?random=20',
        'title': 'Beneficios del ejercicio físico en la diabetes',
        'type': 'Artículo',
      },
      {
        'image': 'https://picsum.photos/80?random=21',
        'title': 'Recomendación de ejercicios para personas con diabetes',
        'type': 'Video',
      },
      {
        'image': 'https://picsum.photos/80?random=22',
        'title': 'Diabetes y ejercicio: Cuándo controlar tu nivel de azúcar',
        'type': 'Artículo',
      },
    ],
    'prevention': [
      {
        'image': 'https://picsum.photos/80?random=30',
        'title': 'Prediabetes: qué es, causas, síntomas y tratamiento',
        'type': 'Artículo',
      },
      {
        'image': 'https://picsum.photos/80?random=31',
        'title': '6 pasos para NUNCA tener diabetes',
        'type': 'Video',
      },
      {
        'image': 'https://picsum.photos/80?random=32',
        'title': 'Cómo prevenir las enfermedades crónicas',
        'type': 'Artículo',
      },
    ],
  };
}
