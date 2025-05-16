// lib/features/risk_evaluation/screens/risk_evaluation_screen.dart
import 'package:flutter/material.dart';
import 'package:gluco_scan/utils/constants/colors.dart';
import '../widgets/risk_evaluation_form.dart';

class RiskEvaluationScreen extends StatelessWidget {
  const RiskEvaluationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LColors.white,
      appBar: AppBar(
        backgroundColor: LColors.primary,
        elevation: 0,
        title: const Text(
          'Evaluación de riesgo de Diabetes',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
      ),
      body: const RiskEvaluationForm(),
    );
  }
}
