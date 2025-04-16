import 'package:flutter/material.dart';

/// -- Light & Dark Elevated Button Theme
class LElevatedButtonTheme {
  LElevatedButtonTheme._();

  ///--- Light Theme
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      // Sin sombra
      elevation: 0,
      // Color del texto
      foregroundColor: const Color(0xFF232651),
      // Fondo blanco para el "botón base" en modo claro
      backgroundColor: Colors.white,
      // Estados deshabilitados
      disabledForegroundColor: Colors.grey.shade400,
      disabledBackgroundColor: Colors.grey.shade200,
      // Sin borde o transparente
      side: BorderSide.none,
      // Altura y espacio interno
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
      // Tipografía semibold y tamaño medio
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      // Forma de cápsula (pill shape)
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
    ),
  );

  ///--- Dark Theme
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      // Texto en blanco
      foregroundColor: Colors.white,
      // Por defecto, un morado oscuro o el que prefieras para fondo del botón en dark
      backgroundColor: const Color(0xFF232651),
      // Estados deshabilitados
      disabledForegroundColor: Colors.grey.shade400,
      disabledBackgroundColor: Colors.grey.shade700,
      side: BorderSide.none,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
    ),
  );
}
