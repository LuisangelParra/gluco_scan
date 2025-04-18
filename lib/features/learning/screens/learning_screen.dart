// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/utils/constants/colors.dart';
import 'package:gluco_scan/routes/app_routes.dart';

/// Pantalla Aprende sobre la diabetes
class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  String _category = 'nutrition';

  final Map<String, String> _titleBg = {
    'nutrition': '#AEEDE4',
    'exercise': '#FFD0BE',
    'prevention': '#FFEDC3',
  };

  final Map<String, Color> _accentColor = {
    'nutrition': const Color(0xFF167B6B),
    'exercise': const Color(0xFFB46242),
    'prevention': const Color(0xFFAE8421),
  };

  final Map<String, IconData> _headerIcon = {
    'nutrition': Icons.restaurant_menu,
    'exercise': Icons.fitness_center,
    'prevention': Icons.shield,
  };

  final Map<String, String> _advice = {
    'nutrition': 'Tomar agua con frecuencia ayuda a controlar los niveles de azúcar.',
    'exercise': '30 minutos de actividad física al día reducen el riesgo de enfermedades crónicas.',
    'prevention': 'Hasta el 80% de enfermedades crónicas se pueden prevenir.',
  };

  final Map<String, List<Map<String, String>>> _content = {
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

  @override
  Widget build(BuildContext context) {
    // Convertir hex a Color
    final bgColor = Color(int.parse(_titleBg[_category]!.substring(1), radix: 16) + 0xFF000000);
    final accent = _accentColor[_category]!;
    final icon = _headerIcon[_category]!;
    final adviceText = _advice[_category]!;
    final items = _content[_category]!;

    return Scaffold(
      backgroundColor: LColors.white,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: const Text(
          'Aprende sobre la diabetes',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
        actions: [Icon(icon, color: Colors.white), const SizedBox(width: 16)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                'Consejos, videos y artículos para cuidar tu salud.',
                style: TextStyle(color: Colors.black87, fontSize: 14),
              ),
              const SizedBox(height: 16),
              // Tarjeta de consejo
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: bgColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(icon, color: accent),
                    const SizedBox(width: 12),
                    Expanded(child: Text(adviceText, style: TextStyle(color: Colors.black87, fontSize: 14))),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Filtros de categoría
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CategoryTab(
                    key: 'nutrition', label: 'Nutrición', bg: accent.withOpacity(_category=='nutrition'?1:0.2), fg: accent,
                    onTap: () => setState(() => _category='nutrition'),
                  ),
                  _CategoryTab(
                    key: 'exercise', label: 'Ejercicio', bg: accent.withOpacity(_category=='exercise'?1:0.2), fg: accent,
                    onTap: () => setState(() => _category='exercise'),
                  ),
                  _CategoryTab(
                    key: 'prevention', label: 'Prevención', bg: accent.withOpacity(_category=='prevention'?1:0.2), fg: accent,
                    onTap: () => setState(() => _category='prevention'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Lista de contenido
              ...items.map((item) => _ContentCard(item, accent)).toList(),
              const SizedBox(height: 24),
              // CTA
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(icon, color: Colors.white),
                label: Text(
                  {
                    'nutrition': 'Come bien, vive mejor.',
                    'exercise': 'Muévete hoy es ganar salud mañana.',
                    'prevention': 'Prevenir hoy es cuidar tu futuro.',
                  }[_category]!,
                  style: const TextStyle(fontSize: 14),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: bgColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  minimumSize: const Size.fromHeight(56),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _CategoryTab({
    required String key,
    required String label,
    required Color bg,
    required Color fg,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 13)),
        ),
      ),
    );
  }

  Widget _ContentCard(Map<String, String> item, Color accent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Image.network(
            item['image']!,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: LColors.lightBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title']!,
                  style: TextStyle(color: accent, decoration: TextDecoration.underline, fontSize: 15),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${item['type']!}',
                  style: TextStyle(color: accent.withOpacity(0.7), fontSize: 13),
                ),
              ],
            ),
          ),
          Icon(Icons.star_border, color: accent),
        ],
      ),
    );
  }
}