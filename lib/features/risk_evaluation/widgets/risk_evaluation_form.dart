// lib/features/risk_evaluation/widgets/risk_evaluation_form.dart

import 'package:flutter/material.dart';
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
                  'Responde estas preguntas para calcular tu riesgo de desarrollar diabetes tipo 2.',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // --- Demográficos ---
                const SectionHeader(
                  icon: Icons.person,
                  title: 'Datos demográficos',
                ),
                const SizedBox(height: 12),

                // Edad
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '¿En cuál de estos rangos de edad te encuentras?',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: DataInputRow.dropdown(
                        label: 'Edad (1–13)',
                        value: ctrl.ageGroup.value.toString(),
                        items: List.generate(13, (i) => (i + 1).toString()),
                        onChanged: ctrl.isEditable.value
                            ? (v) => ctrl.ageGroup.value = int.parse(v!)
                            : null,
                        validator: (v) => v == null ? 'Selecciona edad' : null,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Tooltip(
                      message:
                          '1 = 18–24  • 2 = 25–29 • 3 = 30–34 • 4 = 35–39 • 5 = 40–44 • 6 = 45–49 • 7 = 50–54 • 8 = 55–59 • 9 = 60–64 • 10 = 65–69 • 11 = 70–74 • 12 = 75–79 • 13 = 80+',
                      child: const Icon(Icons.info_outline, size: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Educación
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '¿Cuál es tu nivel educativo más alto completado?',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: DataInputRow.dropdown(
                        label: 'Educación (1–6)',
                        value: ctrl.education.value.toString(),
                        items: List.generate(6, (i) => (i + 1).toString()),
                        onChanged: ctrl.isEditable.value
                            ? (v) => ctrl.education.value = int.parse(v!)
                            : null,
                        validator: (v) => v == null ? 'Selecciona nivel' : null,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Tooltip(
                      message:
                          '1 = Nunca escolarizado • 2 = Grados 1–8 • 3 = Grados 9–11 • 4 = 12/GED • 5 = Universidad 1–3 años • 6 = Universidad 4+ años',
                      child: const Icon(Icons.info_outline, size: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Ingresos
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '¿Cuál es tu ingreso anual del hogar?',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: DataInputRow.dropdown(
                        label: 'Ingresos (1–11)',
                        value: ctrl.income.value.toString(),
                        items: List.generate(11, (i) => (i + 1).toString()),
                        onChanged: ctrl.isEditable.value
                            ? (v) => ctrl.income.value = int.parse(v!)
                            : null,
                        validator: (v) => v == null ? 'Selecciona ingreso' : null,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Tooltip(
                      message:
                          '1 =<\$10k • 2 =<\$15k • 3 =<\$20k • 4 =<\$25k • 5 =<\$35k • 6 =<\$50k • 7 =<\$75k • 8 =<\$100k • 9 =<\$150k • 10 =<\$200k • 11 =>\$200k',
                      child: const Icon(Icons.info_outline, size: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // --- Peso y Altura ---
                const SectionHeader(
                  icon: Icons.monitor_weight,
                  title: 'Peso y altura',
                ),
                const SizedBox(height: 12),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '¿Cuál es tu peso y altura actuales?',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 8),
                DataInputRow.pair(
                  leftLabel: 'Peso (kg)',
                  leftCtrl: ctrl.weightCtrl,
                  rightLabel: 'Altura (cm)',
                  rightCtrl: ctrl.heightCtrl,
                  keyboardType: TextInputType.number,
                  readOnly: !ctrl.isEditable.value,
                  leftValidator: (v) =>
                      (v == null || v.isEmpty) ? 'Ingresa peso' : null,
                  rightValidator: (v) =>
                      (v == null || v.isEmpty) ? 'Ingresa altura' : null,
                ),
                const SizedBox(height: 24),

                // --- Salud general ---
                const SectionHeader(
                  icon: Icons.health_and_safety,
                  title: 'Estado de salud',
                ),
                const SizedBox(height: 12),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '¿Cómo calificarías tu salud general?',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: DataInputRow.dropdown(
                        label: 'Salud (1–5)',
                        value: ctrl.genHealth.value.toString(),
                        items: ['1','2','3','4','5'],
                        onChanged: ctrl.isEditable.value
                            ? (v) => ctrl.genHealth.value = int.parse(v!)
                            : null,
                        validator: (v) => v == null ? 'Selecciona salud' : null,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Tooltip(
                      message:
                          '1 = Excelente • 2 = Muy buena • 3 = Buena • 4 = Regular • 5 = Mala',
                      child: const Icon(Icons.info_outline, size: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '¿Cuántos días en los últimos 30 tu salud mental no fue buena?',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
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
                        validator: (v) =>
                            (v == null || v.isEmpty) ? 'Ingresa días' : null,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Tooltip(
                      message: 'Rango: 0–30 días',
                      child: const Icon(Icons.info_outline, size: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '¿Cuántos días en los últimos 30 tu salud física no fue buena?',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
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
                        validator: (v) =>
                            (v == null || v.isEmpty) ? 'Ingresa días' : null,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Tooltip(
                      message: 'Rango: 0–30 días',
                      child: const Icon(Icons.info_outline, size: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // --- Antecedentes médicos ---
                const SectionHeader(
                  icon: Icons.medical_services,
                  title: 'Antecedentes médicos',
                ),
                const SizedBox(height: 12),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Marca “Sí” si aplica:',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 8),
                QuestionCard(
                  question:
                      '¿Alguna vez un profesional de la salud te dijo que tienes presión arterial alta?',
                  options: const ['No','Sí'],
                  selected: ctrl.highBP.value,
                  onSelected: ctrl.isEditable.value
                      ? (i) => ctrl.highBP.value = i
                      : null,
                  tooltip: '1=Sí • 0=No',
                ),
                const SizedBox(height: 8),
                QuestionCard(
                  question:
                      '¿Alguna vez un profesional de la salud te dijo que tienes colesterol alto?',
                  options: const ['No','Sí'],
                  selected: ctrl.highChol.value,
                  onSelected: ctrl.isEditable.value
                      ? (i) => ctrl.highChol.value = i
                      : null,
                  tooltip: '1=Sí • 0=No',
                ),
                const SizedBox(height: 8),
                QuestionCard(
                  question:
                      '¿Has fumado al menos 100 cigarrillos en tu vida?',
                  options: const ['No','Sí'],
                  selected: ctrl.smoker.value,
                  onSelected: ctrl.isEditable.value
                      ? (i) => ctrl.smoker.value = i
                      : null,
                  tooltip: '1=Sí • 0=No',
                ),
                const SizedBox(height: 8),
                QuestionCard(
                  question: '¿Tienes dificultad seria para caminar o subir escaleras?',
                  options: const ['No','Sí'],
                  selected: ctrl.diffWalk.value,
                  onSelected: ctrl.isEditable.value ? (i) => ctrl.diffWalk.value = i : null,
                ),
                const SizedBox(height: 8),
                QuestionCard(
                  question:
                      '¿Alguna vez te dijeron que tuviste un derrame cerebral?',
                  options: const ['No','Sí'],
                  selected: ctrl.stroke.value,
                  onSelected: ctrl.isEditable.value
                      ? (i) => ctrl.stroke.value = i
                      : null,
                  tooltip: '1=Sí • 0=No',
                ),
                const SizedBox(height: 8),
                QuestionCard(
                  question:
                      '¿Alguna vez te diagnosticaron enfermedad coronaria o infarto?',
                  options: const ['No','Sí'],
                  selected: ctrl.familyHist.value,
                  onSelected: ctrl.isEditable.value
                      ? (i) => ctrl.familyHist.value = i
                      : null,
                  tooltip: '1=Sí • 0=No',
                ),
                const SizedBox(height: 24),

                // --- Actividad física ---
                const SectionHeader(
                  icon: Icons.fitness_center,
                  title: 'Actividad física',
                ),
                const SizedBox(height: 12),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '¿Realizaste actividad física en los últimos 30 días (fuera de trabajo)?',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 8),
                QuestionCard(
                  question: '¿Realizaste actividad física en los últimos 30 días?',
                  tooltip: '1=Sí • 0=No',
                  options: const ['No','Sí'],
                  // ahora usa el RxInt
                  selected: ctrl.physActivity.value,
                  onSelected: ctrl.isEditable.value
                      ? (i) => ctrl.physActivity.value = i
                      : null,
                ),
                const SizedBox(height: 24),

                // --- Consumo de alcohol ---
                const SectionHeader(
                  icon: Icons.local_bar,
                  title: 'Consumo de alcohol',
                ),
                const SizedBox(height: 12),
                QuestionCard(
                  question:
                      '¿Tuviste episodios de consumo excesivo de alcohol en los últimos 30 días?',
                  options: const ['No','Sí'],
                  selected: ctrl.hvyAlcohol.value,
                  onSelected: ctrl.isEditable.value
                      ? (i) => ctrl.hvyAlcohol.value = i
                      : null,
                  tooltip: '1=Sí (heavy drinker) • 0=No',
                ),
                const SizedBox(height: 32),

                // --- Botones ---
                PrimaryButton(
                  label: 'Calcular riesgo',
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
