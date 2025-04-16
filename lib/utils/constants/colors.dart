import 'package:flutter/material.dart';

class LColors {
  LColors._();

  // App Basic Colors
  static const Color primary = Color(0xFF676DB1);         // Color principal (marca)
  static const Color secondary = Color(0xFF167B6B);         // Color secundario (teal)
  static const Color accent = Color(0xFFB46242);            // Color de acento (terracota)

  // Colores adicionales de la paleta
  static const Color lavenderLight = Color(0xFFCFBFE9);     // Lavanda claro
  static const Color darkBlue = Color(0xFF232651);           // Azul oscuro
  static const Color warmPink = Color(0xFFBD536F);           // Rosa cálido
  static const Color blush = Color(0xFFFFE0E8);              // Rubor (rosa pálido)
  static const Color goldenOlive = Color(0xFFAE8421);        // Oliva dorado
  static const Color cream = Color(0xFFFFEDC3);              // Crema
  static const Color amber = Color(0xFFE9BF06);              // Ámbar
  static const Color blueAccent = Color(0xFF4264AE);         // Azul acento
  static const Color coral = Color(0xFFCA4B3A);              // Coral
  static const Color peach = Color(0xFFFFD0BE);              // Durazno
  static const Color mint = Color(0xFFAEEDE4);               // Menta
  static const Color paleMint = Color(0xFFDDF2EF);           // Menta pálida
  static const Color aquaLight = Color(0xFFEFF6F5);          // Aqua claro
  static const Color offWhite = Color(0xFFF9F9FC);           // Blanco roto

  // Colores para redes sociales (opcional)
  static const Color facebook = Color(0xFF1877F2);           // Azul de Facebook
  static const Color googleRed = Color(0xFFDB4437);           // Rojo de Google
  static const Color googleGreen = Color(0xFF0F9D58);         // Verde de Google
  static const Color googleYellow = Color(0xFFF4B400);        // Amarillo de Google
  static const Color googleBlue = Color(0xFF4285F4);          // Azul de Google

  // Text Colors
  static const Color textPrimary = darkBlue;                // Texto principal (usa azul oscuro)
  static const Color textSecondary = Color(0xFF6C757D);       // Texto secundario
  static const Color textWhite = Colors.white;

  // Background Colors
  static const Color lightBackground = offWhite;            // Fondo claro
  static const Color darkBackground = Color(0xFF272727);      // Fondo oscuro
  static const Color primaryBackground = Color(0xFFF3F5FF);   // Fondo primario (ej. en scaffolds)

  // Background Container Colors
  static const Color lightContainer = offWhite;             // Contenedor claro
  static Color darkContainer = Colors.white.withOpacity(0.1); // Contenedor oscuro (transparencia)

  // Button Colors
  static const Color buttonPrimary = primary;               // Botón primario
  static const Color buttonSecondary = secondary;           // Botón secundario
  static const Color buttonDisabled = Color(0xFFC4C4C4);     // Botón deshabilitado

  // Border Colors
  static const Color borderPrimary = Color(0xFFD9D9D9);      // Borde primario
  static const Color borderSecondary = Color(0xFFE6E6E6);     // Borde secundario

  // Error and Validation Colors
  static const Color error = Color(0xFFD32F2F);               // Error
  static const Color success = Color(0xFF388E3C);             // Éxito
  static const Color warning = Color(0xFFF57C00);             // Advertencia
  static const Color info = Color(0xFF1976D2);                // Información

  // Neutral Shades
  static const Color black = Color(0xFF232323);
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softGrey = Color(0xFFF4F4F4);
  static const Color lightGrey = offWhite;
  static const Color white = Color(0xFFFFFFFF);
}
