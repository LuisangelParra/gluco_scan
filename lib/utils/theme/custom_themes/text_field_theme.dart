import 'package:flutter/material.dart';

class LTextFormFieldTheme {
  LTextFormFieldTheme._();

  // Cambia este color a tu lila real, por ejemplo #686DB1
  static const Color lightFillColor = Color(0xFF686DB1);
  // Para el tema oscuro, tal vez quieras un tono lila un poco más oscuro,
  // o incluso usar el mismo color. Lo dejo igual de ejemplo.
  static const Color darkFillColor = Color(0xFF686DB1);

  // Tema claro
  static InputDecorationTheme lightTextFormFieldTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    // Fondo lila para el textField
    fillColor: lightFillColor,
    filled: true,
    labelStyle: const TextStyle(
      fontSize: 14.0,
      color: Colors.white,
    ),
    hintStyle: const TextStyle(
      fontSize: 14.0,
      color: Colors.white70,
    ),
    errorStyle: const TextStyle().copyWith(
      fontStyle: FontStyle.normal,
      color: Colors.red,
    ),
    floatingLabelStyle: const TextStyle(
      fontSize: 14.0,
      color: Colors.white,
    ),
    // Borde de tipo cápsula
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),  // Ajusta el radio a tu gusto
      borderSide: const BorderSide(width: 0, color: Colors.transparent),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: const BorderSide(width: 0, color: Colors.transparent),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: const BorderSide(width: 1, color: Colors.white),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: const BorderSide(width: 1, color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: const BorderSide(width: 1, color: Colors.red),
    ),
  );

  // Tema oscuro
  static InputDecorationTheme darkTextFormFieldTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    fillColor: darkFillColor,
    filled: true,
    labelStyle: const TextStyle(
      fontSize: 14.0,
      color: Colors.white,
    ),
    hintStyle: const TextStyle(
      fontSize: 14.0,
      color: Colors.white70,
    ),
    errorStyle: const TextStyle().copyWith(
      fontStyle: FontStyle.normal,
      color: Colors.red,
    ),
    floatingLabelStyle: const TextStyle(
      fontSize: 14.0,
      color: Colors.white,
    ),
    // Borde de tipo cápsula
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: const BorderSide(width: 0, color: Colors.transparent),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: const BorderSide(width: 0, color: Colors.transparent),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: const BorderSide(width: 1, color: Colors.white),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: const BorderSide(width: 1, color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: const BorderSide(width: 1, color: Colors.red),
    ),
  );
}
