// lib/features/risk_evaluation/widgets/risk_gauge.dart

import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';

class RiskGauge extends StatelessWidget {
  final Map<String, dynamic> resultado;
  const RiskGauge({super.key, required this.resultado});

  @override
  Widget build(BuildContext context) {
    // 1) Extraer probabilidad (0.0–1.0) y pasarla a 0–100
    final raw = (resultado['probabilidad'] as num?)?.toDouble() ?? 0.9;
    final pct = (raw * 100).clamp(0.0, 100.0);

    // 2) Definir umbrales y colores
    const t1 = 33.3, t2 = 66.6;
    const lowColor  = Color(0xFF66BB6A); // verde bajo
    const midColor  = Color(0xFFFFEE58); // ámbar medio
    const highColor = Color(0xFFE53935); // rojo alto

    Color progressColor;
    if (pct <= t1) {
      progressColor = lowColor;
    } else if (pct <= t2) {
      progressColor = midColor;
    } else {
      progressColor = highColor;
    }

    return Center(
      child: AnimatedRadialGauge(
        // Animación y curva
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOutCubic,
        radius: 100,        // radio del semicírculo
        value: pct,         // valor 0–100

        axis: GaugeAxis(
          min: 0,
          max: 100,
          degrees: 180,      // semicírculo
          style: const GaugeAxisStyle(
            thickness: 20,
            background: Color(0xFFE0E0E0), // gris de fondo
            segmentSpacing: 4,
          ),

          // Aguja triangular
          pointer: GaugePointer.triangle(
            width: 16,
            height: 16,
            color: Colors.black87,
            border: GaugePointerBorder(color: Colors.white, width: 2),
          ),

          // Barra de progreso coloreada dinámicamente
          progressBar: GaugeProgressBar.rounded(
            color: progressColor,
          ),
        ),
      ),
    );
  }
}
