import 'package:flutter/material.dart';

/// Botón en forma “pill” con parámetros de color y texto.
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  /// Padding vertical (alto del botón)
  final double verticalPadding;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    this.verticalPadding = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: 0,
          shape: const StadiumBorder(),
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
        ),
        child: Text(label),
      ),
    );
  }
}
