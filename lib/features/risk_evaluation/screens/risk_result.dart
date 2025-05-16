import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/routes/routes.dart';
import 'package:gluco_scan/utils/constants/colors.dart';
import '../widgets/risk_result_header.dart';
import '../widgets/risk_gauge.dart';
import '../widgets/risk_level_list.dart';
import '../widgets/risk_recommendations.dart';

class RiskResultScreen extends StatelessWidget {
  const RiskResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final resultado = Get.arguments as Map<String, dynamic>? ?? {};
    return Scaffold(
      backgroundColor: LColors.white,
      appBar: const RiskResultHeader(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            const IntroText(),
            const SizedBox(height: 24),
            ResultSummary(resultado: resultado),
            const SizedBox(height: 24),
            RiskGauge(resultado: resultado),
            const SizedBox(height: 24),
            RiskLevelList(resultado: resultado),
            const SizedBox(height: 24),
            RiskRecommendations(resultado: resultado),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Get.toNamed(
                  LRoutes.actionPlan,
                  arguments: resultado,
                ),
                icon: const Icon(Icons.visibility),
                label: const Text('Ver plan de acción'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: LColors.mint,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
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

class IntroText extends StatelessWidget {
  const IntroText({super.key});
  @override
  Widget build(BuildContext c) => const Text(
    'Este es el resultado basado en tus respuestas.\n'
    'Sigue las instrucciones para mejorar tu salud.',
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 14, color: Colors.black87),
  );
}

class ResultSummary extends StatelessWidget {
  final Map<String, dynamic> resultado;
  const ResultSummary({super.key, required this.resultado});

  @override
  Widget build(BuildContext context) {
    final clasificacion = resultado['riesgo_diabetes'] ?? 'Desconocido';
    final prob = (resultado['probabilidad'] as num?)?.toDouble() ?? 0.0;
    final bmi = (resultado['imc'] as num?)?.toDouble() ?? 0.0;
    return Column(
      children: [
        Text(
          'Diagnóstico: $clasificacion',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text('Probabilidad estimada: ${(prob * 100).toStringAsFixed(2)}%'),
        const SizedBox(height: 8),
        Text('IMC calculado: ${bmi.toStringAsFixed(1)}'),
        const SizedBox(height: 8),
        Text(
          'Categoría IMC: ${resultado['categoria_imc'] ?? ''}',
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }
}
