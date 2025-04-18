import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/utils/constants/colors.dart';
import 'package:gluco_scan/common/widgets/buttons/primary_button.dart';

class RiskEvaluationScreen extends StatefulWidget {
  const RiskEvaluationScreen({super.key});

  @override
  State<RiskEvaluationScreen> createState() => _RiskEvaluationScreenState();
}

class _RiskEvaluationScreenState extends State<RiskEvaluationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  String? _gender;
  final _exerciseController = TextEditingController();
  int _fruitVegSelected = 0;
  int _tobaccoAlcoholSelected = 0;
  int _familyHistorySelected = 1;
  bool _isEditable = true;

  @override
  void dispose() {
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _exerciseController.dispose();
    super.dispose();
  }

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
      body: Scrollbar(
        thumbVisibility: true,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Descripción
                const Text(
                  'Responde algunas preguntas sobre tu estilo de vida y antecedentes para calcular tu riesgo de desarrollar diabetes.',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 24),

                // Sección: Datos básicos
                const _SectionHeader(
                  icon: Icons.person,
                  title: 'Datos básicos',
                ),
                const SizedBox(height: 12),
                // Edad
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFAEEDE4), // pastel mint
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Edad',
                        style: TextStyle(color: LColors.darkBlue, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: LColors.paleMint,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          controller: _ageController,
                          keyboardType: TextInputType.number,
                          readOnly: !_isEditable,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.black87),
                          decoration: const InputDecoration.collapsed(hintText: ''),
                          validator: (v) => v == null || v.isEmpty ? 'Ingrese su edad' : null,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Género
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFAEEDE4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Género',
                        style: TextStyle(color: LColors.darkBlue, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: LColors.paleMint,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: _gender,
                          items: ['Masculino', 'Femenino', 'Otro']
                              .map((g) => DropdownMenuItem(
                                    value: g,
                                    child: Text(g, style: const TextStyle(color: Colors.black87)),
                                  ))
                              .toList(),
                          decoration: const InputDecoration.collapsed(hintText: ''),
                          style: const TextStyle(color: Colors.black87),
                          onChanged: _isEditable ? (v) => setState(() => _gender = v) : null,
                          validator: (v) => v == null ? 'Seleccione género' : null,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Peso y altura
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFAEEDE4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Peso y altura',
                        style: TextStyle(color: LColors.darkBlue, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: LColors.paleMint,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          controller: _weightController,
                          keyboardType: TextInputType.text,
                          readOnly: !_isEditable,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.black87),
                          decoration: const InputDecoration.collapsed(hintText: ''),
                          validator: (v) => v == null || v.isEmpty ? 'Ingrese peso y altura' : null,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Sección: Hábitos alimenticios
                const _SectionHeader(
                  icon: Icons.apple,
                  title: 'Hábitos alimenticios',
                ),
                const SizedBox(height: 12),
                _QuestionCard(
                  question: '¿Con qué frecuencia comes frutas o verduras?',
                  options: ['Diario', 'A veces', 'Nunca'],
                  selectedIndex: _fruitVegSelected,
                  onChanged: (i) {
                    if (!_isEditable) return;
                    setState(() => _fruitVegSelected = i);
                  },
                  isEditable: _isEditable,
                ),
                const SizedBox(height: 24),

                // Sección: Frecuencia de ejercicio
                const _SectionHeader(
                  icon: Icons.fitness_center,
                  title: 'Frecuencia de ejercicio',
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _exerciseController,
                  keyboardType: TextInputType.number,
                  readOnly: !_isEditable,
                  decoration: InputDecoration(
                    labelText: '¿Cuántos días a la semana haces ejercicio?',
                    labelStyle: const TextStyle(color: Colors.black),
                    floatingLabelStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  filled: true, fillColor: LColors.paleMint,
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (v) => v == null || v.isEmpty ? 'Ingrese días de ejercicio' : null,
                ),
                const SizedBox(height: 24),

                // Sección: Consumo de tabaco y alcohol
                const _SectionHeader(
                  icon: Icons.local_bar,
                  title: 'Consumo de tabaco y alcohol',
                ),
                const SizedBox(height: 12),
                _QuestionCard(
                  question: '¿Con qué frecuencia consumes alcohol o fumas tabaco?',
                  options: ['Diario', 'A veces', 'Nunca'],
                  selectedIndex: _tobaccoAlcoholSelected,
                  onChanged: (i) {
                    if (!_isEditable) return;
                    setState(() => _tobaccoAlcoholSelected = i);
                  },
                  isEditable: _isEditable,
                ),
                const SizedBox(height: 24),

                // Sección: Antecedentes médicos
                const _SectionHeader(
                  icon: Icons.medical_services,
                  title: 'Antecedentes médicos',
                ),
                const SizedBox(height: 12),
                _QuestionCard(
                  question: '¿Tienes familiares con diabetes?',
                  options: ['Sí', 'No'],
                  selectedIndex: _familyHistorySelected,
                  onChanged: (i) {
                    if (!_isEditable) return;
                    setState(() => _familyHistorySelected = i);
                  },
                  isEditable: _isEditable,
                ),
                const SizedBox(height: 32),

                // Botones de acción
                PrimaryButton(
                  label: 'Calcular Riesgo',
                  backgroundColor: LColors.primary,
                  foregroundColor: Colors.white,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() => _isEditable = false);
                      Get.defaultDialog(
                        title: 'Resultado',
                        middleText: 'Tu riesgo estimado es bajo.',
                        textConfirm: 'OK',
                        onConfirm: () => Get.back(),
                      );
                    }
                  },
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _isEditable = true;
                      _formKey.currentState!.reset();
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: LColors.primary),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    minimumSize: const Size.fromHeight(48),
                  ),
                  child: const Text('Editar respuestas'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Encabezado de sección con icono y fondo violeta
class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  const _SectionHeader({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: LColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          )),
        ],
      ),
    );
  }
}

/// Pregunta con opciones tipo chips
class _QuestionCard extends StatelessWidget {
  final String question;
  final List<String> options;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final bool isEditable;
  const _QuestionCard({
    Key? key,
    required this.question,
    required this.options,
    required this.selectedIndex,
    required this.onChanged,
    required this.isEditable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question, style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: options.asMap().entries.map((e) {
            final isSelected = e.key == selectedIndex;
            Color bg;
            Color sel;
            switch (e.key) {
              case 0:
                bg = const Color(0xFFFFD0BE); // pastel peach
                sel = const Color(0xFFB46242); // peach accent
                break;
              case 1:
                bg = const Color(0xFFFFEDC3); // pastel cream
                sel = const Color(0xFFAE8421); // cream accent
                break;
              case 2:
                bg = const Color(0xFFAEEDE4); // pastel mint
                sel = const Color(0xFF167B6B); // mint accent
                break;
              default:
                bg = LColors.lavenderLight;
                sel = LColors.primary;
            }
            return ChoiceChip(
              label: Text(
                e.value,
                style: TextStyle(color: isSelected ? Colors.white : sel),
              ),
              selected: isSelected,
              onSelected: (_) {
                if (!isEditable) return;
                onChanged(e.key);
              },
              backgroundColor: bg,
              selectedColor: sel,
              shape: const StadiumBorder(),
              labelPadding: const EdgeInsets.symmetric(horizontal: 16),
            );
          }).toList(),
        ),
      ],
    );
  }
}