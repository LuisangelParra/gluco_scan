import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/utils/constants/colors.dart';
// import 'dart:ui';

class RiskResultScreen extends StatelessWidget {
  const RiskResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Recibe el nivel de riesgo: 0 = Bajo, 1 = Moderado, 2 = Alto
    final int riskLevel = Get.arguments as int? ?? 0;

    const labels = ['Bajo', 'Moderado', 'Alto'];
    // Colores pastel para el gauge (izquierda→derecha: Alto, Moderado, Bajo)
    final gaugeColors = [
      LColors.primary.withAlpha((0.7 * 255).round()), // Alto/púrpura
      LColors.cream.withAlpha((0.5 * 255).round()),   // Moderado/amarillo
      LColors.accent.withAlpha((0.5 * 255).round()),  // Bajo/durazno
    ];
    final descriptions = [
      '¡Bien hecho! Tu riesgo es bajo, sigue manteniendo hábitos saludables.',
      'Tu riesgo es moderado. Puedes hacer cambios para mejorar tu salud.',
      'Tienes un alto riesgo de diabetes. Es importante tomar medidas pronto.',
    ];
    final recommendations = [
      'Sigue manteniendo una alimentación equilibrada y actividad física regular.',
      'Intenta aumentar tu consumo de vegetales y hacer ejercicio al menos 30 min al día.',
      'Consulta a un profesional de la salud para una evaluación más detallada.',
    ];

    const recommendationBg = [
      Color(0xFFFFD0BE), // Bajo: durazno pastel
      Color(0xFFFFEDC3), // Moderado: crema pastel
      Color(0xFF676DB1), // Alto: púrpura pastel
    ];
    const recommendationTextColor = [
      Color(0xFFB46242), // Bajo accent
      Color(0xFFAE8421), // Moderado accent
      LColors.primary,    // Alto accent
    ];

    return Scaffold(
      backgroundColor: LColors.white,
      appBar: AppBar(
        backgroundColor: LColors.primary,
        elevation: 0,
        title: const Text(
          'Tu nivel de riesgo de Diabetes',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            // Descripción introductoria
            const Text(
              'Este es el resultado basado en tus respuestas.\n'
              'Sigue las instrucciones para mejorar tu salud.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 24),

            // Gauge simulado con tres arcos
            SizedBox(
              height: 120,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(3, (i) {
                      return Container(
                        width: (MediaQuery.of(context).size.width - 32) / 3,
                        height: 80,
                        decoration: BoxDecoration(
                          color: gaugeColors[i],
                          borderRadius: BorderRadius.only(
                            topLeft: i == 0 ? const Radius.circular(40) : Radius.zero,
                            topRight: i == 2 ? const Radius.circular(40) : Radius.zero,
                          ),
                        ),
                      );
                    }),
                  ),
                  // Aguja centrales
                  Container(
                    width: 8,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Listado de niveles con bullet
            for (int i = 0; i < 3; i++) ...[
              Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: gaugeColors[i],
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 120,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      labels[i],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: i == 1
                        // Moderado: description in gray rounded box
                        ? Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                            decoration: BoxDecoration(
                              color: LColors.lavenderLight,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              descriptions[i],
                              style: const TextStyle(color: Colors.black87, fontSize: 12),
                            ),
                          )
                        // Bajo and Alto: plain text
                        : Text(
                            descriptions[i],
                            style: const TextStyle(color: Colors.black87),
                          ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],

            // Encabezado de recomendaciones
            Center(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: LColors.lightBackground,  // light grey background
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Recomendaciones según tu resultado:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Recomendaciones detalladas
            for (int j = 0; j < 3; j++) ...[
              Row(
                children: [
                  Container(
                    width: 120,
                    height: 48,
                    decoration: BoxDecoration(
                      color: recommendationBg[j],
                      borderRadius: BorderRadius.circular(24),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      labels[j],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: j == 2 ? Colors.white : recommendationTextColor[j],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        color: j == riskLevel ? LColors.lavenderLight : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        recommendations[j],
                        style: const TextStyle(color: Colors.black87, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],

            const SizedBox(height: 24),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => Get.toNamed('/action-plan'),
                  icon: const Icon(Icons.visibility),
                  label: const Text('Ver plan de acción'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LColors.mint,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}