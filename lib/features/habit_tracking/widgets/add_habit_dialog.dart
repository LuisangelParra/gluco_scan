// lib/features/habit_tracking/widgets/add_habit_dialog.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/habit_tracking_controller.dart';

class AddHabitDialog extends StatefulWidget {
  const AddHabitDialog({super.key});

  @override
  State<AddHabitDialog> createState() => _AddHabitDialogState();
}

class _AddHabitDialogState extends State<AddHabitDialog> {
  final _titleCtrl = TextEditingController();
  String _category = 'activity';
  String _quantity = '';
  final _ctrl = Get.find<HabitTrackingController>();

  @override
  void dispose() {
    _titleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Añadir nuevo hábito'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleCtrl,
              decoration: const InputDecoration(
                labelText: 'Nombre del hábito',
                border: OutlineInputBorder(),
              ),
              maxLength: 50,
            ),
            const SizedBox(height: 16),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text('Categoría:', style: TextStyle(fontWeight: FontWeight.w500))),
            RadioListTile<String>(
              title: const Text('Actividad Física'),
              value: 'activity',
              groupValue: _category,
              onChanged: (v) => setState(() => _category = v!),
              activeColor: Colors.teal,
            ),
            RadioListTile<String>(
              title: const Text('Alimentación Saludable'),
              value: 'nutrition',
              groupValue: _category,
              onChanged: (v) => setState(() => _category = v!),
              activeColor: Colors.green,
            ),
            RadioListTile<String>(
              title: const Text('Sueño'),
              value: 'sleep',
              groupValue: _category,
              onChanged: (v) => setState(() => _category = v!),
              activeColor: const Color(0xFF5956A6),
            ),
            if (_category == 'sleep' || _category == 'nutrition' || _category == 'activity')
              TextField(
                decoration: InputDecoration(
                  labelText: _category == 'sleep'
                      ? 'Horas dormidas'
                      : _category == 'nutrition'
                          ? 'Cantidad de comida'
                          : 'Duración / tipo actividad',
                  border: const OutlineInputBorder(),
                ),
                keyboardType: _category == 'sleep' ? TextInputType.number : TextInputType.text,
                onChanged: (v) => _quantity = v,
              ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
        ElevatedButton(
          onPressed: () {
            final title = _titleCtrl.text.trim();
            if (title.isNotEmpty) {
              _ctrl.addHabit(title, _category, _quantity);
              Navigator.pop(context);
            }
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
