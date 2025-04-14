import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract final class AppTheme {
  // Ejemplo de tema claro definido manualmente para una versión anterior
  static ThemeData light = FlexThemeData.light(
    colors: const FlexSchemeColor(
      primary: Color(0xFF686DB1),
      primaryContainer: Color(0xFFD2D3F2),
      secondary: Color(0xFF686DB1),
      secondaryContainer: Color(0xFFD2D3F2),
      tertiary: Color(0xFF686DB1),
      tertiaryContainer: Color(0xFFD2D3F2),
      appBarColor: Color(0xFFD2D3F2),
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

  // Ejemplo de tema oscuro definido manualmente para una versión anterior
  static ThemeData dark = FlexThemeData.dark(
    colors: const FlexSchemeColor(
      primary: Color(0xFF686DB1),
      primaryContainer: Color(0xFFD2D3F2),
      primaryLightRef: Color(0xFF686DB1),
      secondary: Color(0xFF686DB1),
      secondaryContainer: Color(0xFFD2D3F2),
      secondaryLightRef: Color(0xFF686DB1),
      tertiary: Color(0xFF686DB1),
      tertiaryContainer: Color(0xFFD2D3F2),
      tertiaryLightRef: Color(0xFF686DB1),
      appBarColor: Color(0xFF444A80),
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
