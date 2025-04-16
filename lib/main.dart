import 'package:flutter/material.dart';
///import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gluco_scan/app.dart';

Future<void> main() async {
  // Widgets Binding
  ///final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  
  // -- GetX Local Storage
  await GetStorage.init();

  // -- Await Splash until other items loaded
  ///FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const App());
}
