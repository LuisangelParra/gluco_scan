// lib/features/dashboard/widgets/add_data_dialog.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/sizes.dart';

class AddDataDialog extends StatelessWidget {
  final TextEditingController gCtrl, iCtrl, hCtrl;
  final VoidCallback onSave;

  const AddDataDialog({
    super.key,
    required this.gCtrl,
    required this.iCtrl,
    required this.hCtrl,
    required this.onSave,
  });

  Widget _field(String label, TextEditingController ctrl) {
    return TextField(
      controller: ctrl,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(LSizes.cardRadiusMd),
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: LSizes.md,
          vertical: LSizes.md,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(LSizes.cardRadiusMd),
      ),
      title: const Text('Añade tus datos'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _field('Glucosa (mmol/L)', gCtrl),
            const SizedBox(height: LSizes.spaceBtwItems),
            _field('Insulina (mg/dL)', iCtrl),
            const SizedBox(height: LSizes.spaceBtwItems),
            _field('Ritmo cardíaco (bpm)', hCtrl),
          ],
        ),
      ),
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: LSizes.md,
        vertical: LSizes.sm,
      ),
      actions: [
        TextButton(
          onPressed: Get.back,
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: onSave,
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
