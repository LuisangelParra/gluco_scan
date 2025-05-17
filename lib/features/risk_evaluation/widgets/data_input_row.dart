// lib/features/risk_evaluation/widgets/data_input_row.dart
import 'package:flutter/material.dart';
import 'package:gluco_scan/utils/constants/colors.dart';

typedef Validator = String? Function(String?);

class DataInputRow extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final bool readOnly;
  final Validator? validator;

  // Para dropdown
  final String? value;
  final List<String>? items;
  final ValueChanged<String?>? onChanged;

  // Para par (peso/altura)
  final String? leftLabel, rightLabel;
  final TextEditingController? leftCtrl, rightCtrl;
  final Validator? leftValidator, rightValidator;

  const DataInputRow({
    super.key,
    required this.label,
    this.controller,
    this.readOnly = false,
    this.validator, required TextInputType keyboardType,
  })  : value = null,
        items = null,
        onChanged = null,
        leftLabel = null,
        rightLabel = null,
        leftCtrl = null,
        rightCtrl = null,
        leftValidator = null,
        rightValidator = null;

  const DataInputRow.dropdown({
    super.key,
    required this.label,
    this.value,
    required this.items,
    this.onChanged,
    this.validator,
  })  : controller = null,
        readOnly = false,
        leftLabel = null,
        rightLabel = null,
        leftCtrl = null,
        rightCtrl = null,
        leftValidator = null,
        rightValidator = null;

  const DataInputRow.pair({
    super.key,
    required this.leftLabel,
    required this.leftCtrl,
    required this.rightLabel,
    required this.rightCtrl,
    this.readOnly = false,
    this.leftValidator,
    this.rightValidator, required TextInputType keyboardType,
  })  : label = null,
        controller = null,
        validator = null,
        value = null,
        items = null,
        onChanged = null;

  @override
  Widget build(BuildContext context) {
    if (items != null) {
      // dropdown
      return Row(
        children: [
          _labelContainer(label!),
          const SizedBox(width: 12),
          Expanded(
            child: _inputContainer(
              child: DropdownButtonFormField<String>(
                value: value,
                items: items!
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
                decoration: const InputDecoration.collapsed(hintText: ''),
                onChanged: onChanged,
                validator: validator,
              ),
            ),
          ),
        ],
      );
    }
    if (leftCtrl != null && rightCtrl != null) {
      // pair
      return Row(
        children: [
          _labelContainer(leftLabel!),
          const SizedBox(width: 12),
          Expanded(
            child: _dualInput(leftCtrl!, leftValidator),
          ),
          const SizedBox(width: 12),
          _labelContainer(rightLabel!),
          const SizedBox(width: 12),
          Expanded(
            child: _dualInput(rightCtrl!, rightValidator),
          ),
        ],
      );
    }
    // single
    return Row(
      children: [
        _labelContainer(label!),
        const SizedBox(width: 12),
        Expanded(
          child: _inputContainer(
            child: TextFormField(
              controller: controller,
              readOnly: readOnly,
              textAlign: TextAlign.center,
              decoration: const InputDecoration.collapsed(hintText: ''),
              style: const TextStyle(color: Colors.black87),
              validator: validator,
            ),
          ),
        ),
      ],
    );
  }

  Widget _labelContainer(String txt) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFAEEDE4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(txt, style: TextStyle(color: LColors.darkBlue, fontWeight: FontWeight.w600)),
      );

  Widget _inputContainer({required Widget child}) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(color: LColors.paleMint, borderRadius: BorderRadius.circular(20)),
        child: child,
      );

  Widget _dualInput(TextEditingController ctrl, Validator? val) => TextFormField(
        controller: ctrl,
        keyboardType: TextInputType.number,
        readOnly: readOnly,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black87),
        decoration: const InputDecoration.collapsed(hintText: ''),
        validator: val,
      );
}
