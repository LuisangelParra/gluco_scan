import 'package:flutter/material.dart';
import 'package:gluco_scan/utils/theme/custom_themes/text_theme.dart';

import '../constants/colors.dart';
import 'custom_themes/appbar_theme.dart';
import 'custom_themes/bottom_sheet_theme.dart';
import 'custom_themes/checkbox_theme.dart';
import 'custom_themes/chip_theme.dart';
import 'custom_themes/elevated_button_theme.dart';
import 'custom_themes/outlined_button_theme.dart';
import 'custom_themes/text_field_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'InstrumentSans',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    textTheme: LTexTheme.lightTextTheme,
    chipTheme: LChipTheme.lightChipTheme,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: LAppBarTheme.lightAppBarTheme,
    checkboxTheme: LCheckBoxTheme.lightCheckBoxTheme,
    bottomSheetTheme: LBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: LElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: LOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: LTextFormFieldTheme.lightTextFormFieldTheme,
  ); // ThemeData
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'InstrumentSans',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    textTheme: LTexTheme.darkTextTheme,
    chipTheme: LChipTheme.darkChipTheme,
    scaffoldBackgroundColor:LColors.darkBackground,
    appBarTheme: LAppBarTheme.darkAppBarTheme,
    checkboxTheme: LCheckBoxTheme.darkCheckBoxTheme,
    bottomSheetTheme: LBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: LElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: LOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: LTextFormFieldTheme.darkTextFormFieldTheme,
  );
}