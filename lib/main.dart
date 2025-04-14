import 'package:flutter/material.dart';
import 'package:gluco_scan/home_page.dart';
import 'package:gluco_scan/themes/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  void toggleTheme(){
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      darkTheme: AppTheme.dark,
      theme: AppTheme.light,
      home: HomePage(onThemeChanged: toggleTheme),
    );
  }
}
