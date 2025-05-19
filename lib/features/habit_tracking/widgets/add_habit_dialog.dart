// lib/features/habit_tracking/widgets/add_habit_dialog.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/utils/constants/colors.dart';
import 'package:gluco_scan/features/habit_tracking/controllers/habit_tracking_controller.dart';

class AddHabitDialog extends StatefulWidget {
  const AddHabitDialog({super.key});
  @override
  State<AddHabitDialog> createState() => _AddHabitDialogState();
}

class _AddHabitDialogState extends State<AddHabitDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl  = TextEditingController();
  final _targetCtrl = TextEditingController();

  String _category  = 'activity';
  final String _frequency = 'Diario';
  TimeOfDay? _reminderTime;

  final _frequencies = ['Diario', 'Semanal', 'Mensual'];
  final _ctrl = Get.find<HabitTrackingController>();

  @override
  void dispose() {
    _titleCtrl.dispose();
    _targetCtrl.dispose();
    super.dispose();
  }

  // Future<void> _pickReminderTime() async {
  //   // Por ahora deshabilitado, pero el UI queda para futura implementación.
  //   // final picked = await showTimePicker(...);
  //   // if (picked != null) setState(() => _reminderTime = picked);
  // }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: LColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('Añadir hábito personalizado', style: TextStyle(color: LColors.white),),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ----- TÍTULO -----
              TextFormField(
                controller: _titleCtrl,
                decoration: InputDecoration(
                  labelText: 'Nombre del hábito',
                  labelStyle: const TextStyle(color: LColors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: LColors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: LColors.white, width: 2),
                  ),
                  counterStyle: const TextStyle(color: LColors.white),
                ),
                maxLength: 50,
                style: const TextStyle(color: LColors.white),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Requerido' : null,
              ),
              const SizedBox(height: 16),

              // ----- CATEGORÍA -----
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Categoría',
                  style: TextStyle(
                    color: LColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  _buildCategoryChip('activity', 'Actividad', Icons.directions_run),
                  _buildCategoryChip('nutrition', 'Alimentación', Icons.eco),
                  _buildCategoryChip('sleep', 'Sueño', Icons.nightlight_round),
                  _buildCategoryChip('other', 'Otro', Icons.check),
                ],
              ),
              const SizedBox(height: 16),

              // ----- META / CANTIDAD -----
              TextFormField(
                controller: _targetCtrl,
                decoration: InputDecoration(
                  labelText: _category == 'sleep'
                      ? 'Horas objetivo'
                      : 'Meta (p.ej. "30 min")',
                  filled: true,
                  fillColor: LColors.primary.withOpacity(0.05),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: LColors.white, width: 2),
                  ),
                ),
                keyboardType: _category == 'sleep'
                    ? TextInputType.number
                    : TextInputType.text,
                style: const TextStyle(color: LColors.white),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Requerido' : null,
              ),
              const SizedBox(height: 16),

              // ----- FRECUENCIA (deshabilitado) -----
              DropdownButtonFormField<String>(
                value: _frequency,
                decoration: InputDecoration(
                  labelText: 'Frecuencia',
                  filled: true,
                  fillColor: LColors.primary.withOpacity(0.05),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: _frequencies
                    .map((f) => DropdownMenuItem(
                          value: f,
                          child: Text(f, style: const TextStyle(color: LColors.darkBlue)),
                        ))
                    .toList(),
                onChanged: null, // aún no activo
                disabledHint: Text(_frequency, style: const TextStyle(color: LColors.darkBlue)),
              ),
              const SizedBox(height: 16),

              // ----- RECORDATORIO (deshabilitado) -----
              GestureDetector(
                onTap: null, // aún no activo
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Recordatorio',
                    filled: true,
                    fillColor: LColors.primary.withOpacity(0.05),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _reminderTime == null
                            ? 'Sin recordatorio'
                            : _reminderTime!.format(context),
                        style: const TextStyle(color: LColors.darkBlue),
                      ),
                      Icon(Icons.access_time, color: LColors.primary),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancelar', style: TextStyle(color: LColors.primary)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: LColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;
            final qty = [
              _targetCtrl.text.trim(),
              _frequency,
              if (_reminderTime != null) _reminderTime!.format(context),
            ].join(' · ');
            _ctrl.addHabit(
              _titleCtrl.text.trim(),
              _category,
              qty,
            );
            Navigator.pop(context);
          },
          child: const Text('Guardar', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildCategoryChip(String value, String label, IconData icon) {
    final selected = _category == value;
    return ChoiceChip(
      label: Text(label),
      avatar: Icon(icon, size: 20, color: selected ? Colors.white : LColors.primary),
      selected: selected,
      onSelected: (_) => setState(() => _category = value),
      selectedColor: LColors.secondary,
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: selected ? Colors.white : LColors.secondary,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
