// lib/features/risk_evaluation/widgets/risk_evaluation_form.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/common/widgets/buttons/primary_button.dart';
import 'package:gluco_scan/utils/constants/colors.dart';

import '../controllers/risk_evaluation_controller.dart';
import 'section_header.dart';
import 'data_input_row.dart';
import 'question_card.dart';

class RiskEvaluationForm extends StatelessWidget {
  const RiskEvaluationForm({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(RiskEvaluationController());
    return Obx(() {
      if (ctrl.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return Scrollbar(
        thumbVisibility: true,
        child: Form(
          key: ctrl.formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Responde algunas preguntas sobre tu estilo de vida y antecedentes para calcular tu riesgo de desarrollar diabetes.',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // --- Demográficos ---
                const SectionHeader(icon: Icons.person, title: 'Datos demográficos'),
                const SizedBox(height: 12),

                // Pregunta edad
                const Text(
                  '¿En qué rango de edad te encuentras?',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: DataInputRow.dropdown(
                        label: 'Edad (categoría 1–13)',
                        value: ctrl.ageCategory.value.toString(),
                        items: List.generate(13, (i) => (i + 1).toString()),
                        onChanged: ctrl.isEditable.value
                            ? (v) => ctrl.ageCategory.value = int.parse(v!)
                            : null,
                        validator: (v) => v == null ? 'Seleccione edad' : null,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Tooltip(
                      message: '1=18–24, 9=60–64, 13=80+',
                      child: const Icon(Icons.info_outline, size: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Pregunta ingresos
                const Text(
                  '¿Cuál es tu nivel de ingresos anuales?',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: DataInputRow.dropdown(
                        label: 'Ingresos (1–8)',
                        value: ctrl.income.value.toString(),
                        items: List.generate(8, (i) => (i + 1).toString()),
                        onChanged: ctrl.isEditable.value
                            ? (v) => ctrl.income.value = int.parse(v!)
                            : null,
                        validator: (v) => v == null ? 'Seleccione ingresos' : null,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Tooltip(
                      message: '1=<\$10k • 5=<\$35k • 8=>\$75k',
                      child: const Icon(Icons.info_outline, size: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // --- Peso y Altura ---
                const SectionHeader(icon: Icons.monitor_weight, title: 'Peso y altura'),
                const SizedBox(height: 12),

                const Text(
                  '¿Cuál es tu peso y altura actuales?',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                DataInputRow.pair(
                  leftLabel: 'Peso (kg)',
                  leftCtrl: ctrl.weightCtrl,
                  rightLabel: 'Altura (cm)',
                  rightCtrl: ctrl.heightCtrl,
                  keyboardType: TextInputType.number,
                  readOnly: !ctrl.isEditable.value,
                  leftValidator: (v) => (v == null || v.isEmpty) ? 'Ingrese peso' : null,
                  rightValidator: (v) => (v == null || v.isEmpty) ? 'Ingrese altura' : null,
                ),
                const SizedBox(height: 24),

                // --- Estado de salud ---
                const SectionHeader(icon: Icons.health_and_safety, title: 'Estado de salud'),
                const SizedBox(height: 12),

                const Text(
                  'Salud general:',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: DataInputRow.dropdown(
                        label: 'Salud general (1–5)',
                        value: ctrl.genHealth.value.toString(),
                        items: ['1','2','3','4','5'],
                        onChanged: ctrl.isEditable.value
                            ? (v) => ctrl.genHealth.value = int.parse(v!)
                            : null,
                        validator: (v) => v == null ? 'Seleccione salud general' : null,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Tooltip(
                      message: '1=Excelente • 5=Deficiente',
                      child: const Icon(Icons.info_outline, size: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                const Text(
                  '¿Cuántos días de los últimos 30 sentiste tu salud mental no buena?',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: DataInputRow(
                        label: 'Días mental',
                        controller: ctrl.mentHealthCtrl,
                        keyboardType: TextInputType.number,
                        readOnly: !ctrl.isEditable.value,
                        validator: (v) => (v == null || v.isEmpty) ? 'Ingrese días' : null,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Tooltip(
                      message: '0–30 días',
                      child: const Icon(Icons.info_outline, size: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                const Text(
                  '¿Cuántos días de los últimos 30 tu salud física no estuvo buena?',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: DataInputRow(
                        label: 'Días física',
                        controller: ctrl.physHealthCtrl,
                        keyboardType: TextInputType.number,
                        readOnly: !ctrl.isEditable.value,
                        validator: (v) => (v == null || v.isEmpty) ? 'Ingrese días' : null,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Tooltip(
                      message: '0–30 días',
                      child: const Icon(Icons.info_outline, size: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // --- Antecedentes médicos (binario) ---
                const SectionHeader(icon: Icons.medical_services, title: 'Antecedentes médicos'),
                const SizedBox(height: 12),

                const Text(
                  'Marca “Sí” si aplica:',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                QuestionCard(
                  question: '¿Tienes presión arterial alta?',
                  options: const ['No','Sí'],
                  selected: ctrl.highBP.value,
                  onSelected: ctrl.isEditable.value ? (i) => ctrl.highBP.value = i : null,
                ),
                const SizedBox(height: 8),
                QuestionCard(
                  question: '¿Tienes colesterol alto?',
                  options: const ['No','Sí'],
                  selected: ctrl.highChol.value,
                  onSelected: ctrl.isEditable.value ? (i) => ctrl.highChol.value = i : null,
                ),
                const SizedBox(height: 8),
                QuestionCard(
                  question: '¿Chequeaste colesterol en 5 años?',
                  options: const ['No','Sí'],
                  selected: ctrl.cholCheck.value,
                  onSelected: ctrl.isEditable.value ? (i) => ctrl.cholCheck.value = i : null,
                ),
                const SizedBox(height: 8),
                QuestionCard(
                  question: '¿Has fumado ≥100 cigarrillos?',
                  options: const ['No','Sí'],
                  selected: ctrl.smoker.value,
                  onSelected: ctrl.isEditable.value ? (i) => ctrl.smoker.value = i : null,
                ),
                const SizedBox(height: 8),
                QuestionCard(
                  question: '¿Tienes dificultad para caminar?',
                  options: const ['No','Sí'],
                  selected: ctrl.diffWalk.value,
                  onSelected: ctrl.isEditable.value ? (i) => ctrl.diffWalk.value = i : null,
                ),
                const SizedBox(height: 8),
                QuestionCard(
                  question: '¿Alguna vez te dijeron que tuviste un derrame cerebral?',
                  options: const ['No','Sí'],
                  selected: ctrl.stroke.value,
                  onSelected: ctrl.isEditable.value ? (i) => ctrl.stroke.value = i : null,
                ),
                const SizedBox(height: 8),
                QuestionCard(
                  question: '¿Enfermedad coronaria o infarto?',
                  options: const ['No','Sí'],
                  selected: ctrl.familyHist.value,
                  onSelected: ctrl.isEditable.value ? (i) => ctrl.familyHist.value = i : null,
                ),
                const SizedBox(height: 24),

                // --- Actividad física (binario) ---
                const SectionHeader(icon: Icons.fitness_center, title: 'Actividad física'),
                const SizedBox(height: 12),
                const Text(
                  '¿Realizaste alguna actividad física en los últimos 30 días?',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                QuestionCard(
                  question: 'Actividad física en los ultimos 30 días?',
                  options: const ['No','Sí'],
                  selected: ctrl.exerciseCtrl.text.trim().isEmpty ? 0 : 1,
                  onSelected: ctrl.isEditable.value
                      ? (i) => ctrl.exerciseCtrl.text = (i == 1 ? '1' : '')
                      : null,
                ),

                const SizedBox(height: 32),

                // --- Botones ---
                PrimaryButton(
                  label: 'Calcular Riesgo',
                  backgroundColor: LColors.primary,
                  foregroundColor: Colors.white,
                  onPressed: ctrl.submit,
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () => ctrl.isEditable.value = true,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: LColors.primary),
                    minimumSize: const Size.fromHeight(48),
                  ),
                  child: const Text('Editar respuestas'),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
