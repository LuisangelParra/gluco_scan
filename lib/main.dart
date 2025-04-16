import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gluco_scan/app.dart';
import 'package:gluco_scan/home_page.dart';
import 'package:gluco_scan/themes/app_theme.dart';

Future<void> main() async {
  // Widgets Binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  
  // -- GetX Local Storage
  await GetStorage.init();

  // -- Await Splash until other items loaded
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const App());
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
