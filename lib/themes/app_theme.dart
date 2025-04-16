import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract final class AppTheme {
  // Tema claro basado en los diseños de GlucoScan y la paleta de colores.
  static ThemeData light = FlexThemeData.light(
    colors: const FlexSchemeColor(
      primary: Color(0xFF686DB1),         // Color de marca.
      primaryContainer: Color(0xFFCFBFE9),  // Variante clara derivada.
      secondary: Color(0xFF167B6B),         // Tono teal.
      secondaryContainer: Color(0xFFDDF2EF),// Contenedor muy claro para secundarios.
      tertiary: Color(0xFFB46242),          // Acento cálido (naranja quemado).
      tertiaryContainer: Color(0xFFFFD0BE), // Variante clara del acento.
      appBarColor: Color(0xFFF9F9FC),       // Fondo muy claro para la AppBar.
      swapOnMaterial3: true,
    ),
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );

  // Tema oscuro basado en los diseños de GlucoScan y la paleta de colores.
  static ThemeData dark = FlexThemeData.dark(
    colors: const FlexSchemeColor(
      primary: Color(0xFF686DB1),         // Se mantiene el color de marca.
      primaryContainer: Color(0xFF232651),  // Variante oscura para fondos.
      primaryLightRef: Color(0xFF686DB1),   // Referencia a la versión clara.
      secondary: Color(0xFF167B6B),         // Tono teal.
      secondaryContainer: Color(0xFF4264AE),// Contenedor oscuro para elementos secundarios.
      secondaryLightRef: Color(0xFF167B6B), // Referencia a la versión clara.
      tertiary: Color(0xFFCA4B3A),          // Acento adaptado al modo oscuro.
      tertiaryContainer: Color(0xFFFFD0BE), // Se mantiene coherencia en la variante.
      appBarColor: Color(0xFF444A80),       // Fondo oscuro para la AppBar.
      swapOnMaterial3: true,
    ),
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnColors: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
}
