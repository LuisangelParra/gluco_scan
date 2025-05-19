// lib/features/risk_evaluation/screens/risk_result_screen.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/routes/routes.dart';
import 'package:gluco_scan/utils/constants/colors.dart';

import '../widgets/risk_result_header.dart';
import '../widgets/risk_gauge.dart';
import '../widgets/risk_level_list.dart';
import '../widgets/risk_recommendations.dart';

class RiskResultScreen extends StatelessWidget {
  const RiskResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Si no está logueado, lo mandamos a evaluación
      Future.microtask(() => Get.offNamed(LRoutes.riskEval));
      return const Scaffold(body: SizedBox());
    }

    // Referencia a la colección ordenada por timestamp descendente
    final evaluationsRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .collection('RiskEvaluations')
        .orderBy('timestamp', descending: true)
        .limit(1);

    return FutureBuilder<QuerySnapshot>(
      future: evaluationsRef.get(),
      builder: (context, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snap.hasError || snap.data == null || snap.data!.docs.isEmpty) {
          // No hay nada guardado aún → a evaluar
          Future.microtask(() => Get.offNamed(LRoutes.riskEval));
          return const Scaffold(body: SizedBox());
        }

        // Tomamos el primer (más reciente) documento:
        final doc = snap.data!.docs.first;
        final raw = doc.data() as Map<String, dynamic>;

        // **AQUÍ** extraemos el sub‐mapa "result" si existe,
        // sino usamos todo el documento (por compatibilidad).
        final resultado = (raw['result'] is Map)
            ? Map<String, dynamic>.from(raw['result'])
            : raw;

        return Scaffold(
          backgroundColor: LColors.white,
          appBar: const RiskResultHeader(),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              children: [
                const _IntroText(),
                const SizedBox(height: 24),
                _ResultSummary(resultado: resultado),
                const SizedBox(height: 24),
                RiskGauge(resultado: resultado),
                const SizedBox(height: 24),
                RiskLevelList(resultado: resultado),
                const SizedBox(height: 24),
                RiskRecommendations(resultado: resultado),
                const SizedBox(height: 32),
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
                      backgroundColor: LColors.primary,
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
      },
    );
  }
}

class _IntroText extends StatelessWidget {
  const _IntroText();
  @override
  Widget build(BuildContext c) => const Text(
        'Este es el resultado basado en tus respuestas.\n'
        'Sigue las instrucciones para mejorar tu salud.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14, color: Colors.black87),
      );
}

class _ResultSummary extends StatelessWidget {
  final Map<String, dynamic> resultado;
  const _ResultSummary({Key? key, required this.resultado}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final riesgo = resultado['riesgo_diabetes'] as String? ?? 'Desconocido';
    final prob = (resultado['probabilidad'] as num?)?.toDouble() ?? 0.0;
    final bmi = (resultado['imc'] as num?)?.toDouble() ?? 0.0;
    final categoria = resultado['categoria_imc'] as String? ?? '';

    return Column(
      children: [
        Text(
          'Diagnóstico: $riesgo',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text('Probabilidad estimada: ${(prob * 100).toStringAsFixed(2)}%'),
        const SizedBox(height: 8),
        Text('IMC calculado: ${bmi.toStringAsFixed(1)}'),
        const SizedBox(height: 8),
        Text(
          'Categoría IMC: $categoria',
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }
}
