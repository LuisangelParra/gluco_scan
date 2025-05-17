// lib/features/dashboard/widgets/add_data_dialog.dart
import 'package:flutter/material.dart';
import 'package:gluco_scan/utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class AddDataDialog extends StatelessWidget {
  final TextEditingController gCtrl, iCtrl, hCtrl;
  final VoidCallback? onSave;
  final Color? backgroundColor;

  const AddDataDialog({
    super.key,
    required this.gCtrl,
    required this.iCtrl,
    required this.hCtrl,
    this.onSave,
    this.backgroundColor,
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
      backgroundColor: backgroundColor,            // <— aquí
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(LSizes.cardRadiusMd),
      ),
      title: const Text('Añade tus datos', style: TextStyle(color: LColors.aquaLight),),
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
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar', style: TextStyle(color: LColors.aquaLight),),
          
        ),
        ElevatedButton(
          onPressed: onSave,                        // <— deshabilita si es null
          child: const Text('Guardar', style: TextStyle(color: LColors.primary),),
        ),
      ],
    );
  }
}
