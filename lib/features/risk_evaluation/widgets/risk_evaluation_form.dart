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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Responde algunas preguntas sobre tu estilo de vida y antecedentes para calcular tu riesgo de desarrollar diabetes.',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 24),

                // --- Datos básicos ---
                const SectionHeader(icon: Icons.person, title: 'Datos básicos'),
                const SizedBox(height: 12),
                DataInputRow(
                  label: 'Edad',
                  controller: ctrl.ageCtrl,
                  readOnly: !ctrl.isEditable.value,
                  validator: (v) => (v==null||v.isEmpty)?'Ingrese su edad':null,
                ),
                const SizedBox(height: 12),
                DataInputRow.dropdown(
                  label: 'Género',
                  value: ctrl.gender.value,
                  items: const ['Masculino','Femenino','Otro'],
                  onChanged: ctrl.isEditable.value ? (v)=>ctrl.gender.value=v : null,
                  validator: (v) => v==null ? 'Seleccione género' : null,
                ),
                const SizedBox(height: 12),
                DataInputRow.pair(
                  leftLabel: 'Peso (kg)',
                  leftCtrl: ctrl.weightCtrl,
                  rightLabel: 'Altura (cm)',
                  rightCtrl: ctrl.heightCtrl,
                  readOnly: !ctrl.isEditable.value,
                  leftValidator: (v)=>(v==null||v.isEmpty)?'Ingrese peso':null,
                  rightValidator:(v)=>(v==null||v.isEmpty)?'Ingrese altura':null,
                ),

                const SizedBox(height: 24),

                // --- Hábitos alimenticios ---
                const SectionHeader(icon: Icons.apple, title: 'Hábitos alimenticios'),
                const SizedBox(height: 12),
                QuestionCard(
                  question: '¿Con qué frecuencia comes frutas o verduras?',
                  options: const ['Diario','A veces','Nunca'],
                  selected: ctrl.fruitVeg.value,
                  onSelected: ctrl.isEditable.value ? (i)=>ctrl.fruitVeg.value=i : null,
                ),

                const SizedBox(height: 24),

                // --- Ejercicio ---
                const SectionHeader(icon: Icons.fitness_center, title: 'Frecuencia de ejercicio'),
                const SizedBox(height: 12),
                TextFormField(
                  controller: ctrl.exerciseCtrl,
                  keyboardType: TextInputType.number,
                  readOnly: !ctrl.isEditable.value,
                  decoration: InputDecoration(
                    labelText: '¿Cuántos días a la semana haces ejercicio?',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    filled: true, fillColor: LColors.paleMint,
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (v)=>(v==null||v.isEmpty)?'Ingrese días de ejercicio':null,
                ),

                const SizedBox(height: 24),

                // --- Tabaco / Alcohol ---
                const SectionHeader(icon: Icons.local_bar, title: 'Consumo de tabaco y alcohol'),
                const SizedBox(height: 12),
                QuestionCard(
                  question: '¿Con qué frecuencia consumes alcohol o fumas tabaco?',
                  options: const ['Diario','A veces','Nunca'],
                  selected: ctrl.tobaccoAlc.value,
                  onSelected: ctrl.isEditable.value ? (i)=>ctrl.tobaccoAlc.value=i : null,
                ),

                const SizedBox(height: 24),

                // --- Antecedentes médicos ---
                const SectionHeader(icon: Icons.medical_services, title: 'Antecedentes médicos'),
                const SizedBox(height: 12),
                QuestionCard(
                  question: '¿Tienes familiares con diabetes?',
                  options: const ['Sí','No'],
                  selected: ctrl.familyHist.value,
                  onSelected: ctrl.isEditable.value ? (i)=>ctrl.familyHist.value=i : null,
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
