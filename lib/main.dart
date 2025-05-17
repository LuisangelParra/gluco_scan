import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gluco_scan/app.dart';
import 'package:get/get.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:gluco_scan/data/repositories/authentication/authentication_repository.dart';
import 'package:gluco_scan/data/repositories/dashboard/measurement_repository.dart';
import 'firebase_options.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> main() async {
  // Widgets Binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('America/Bogota'));
  
  // -- GetX Local Storage
  await GetStorage.init();

  // -- Await Splash until other items loaded
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // -- Firebase Initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
    (FirebaseApp value) => Get.put(AuthenticationRepository()),
  );
  Get.put(MeasurementRepository());

  // -- Await Splash until other items loaded
  ///FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const App());
}
