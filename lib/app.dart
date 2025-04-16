import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/bindings/general_bindings.dart';

import 'package:gluco_scan/utils/theme/theme.dart';

import 'utils/constants/colors.dart';

/// -- Use this class to setup themes, inital Bindings, any animations and much more
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.light,
      theme: LAppTheme.lightTheme,
      darkTheme: LAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      

      /// Show Loader or Circular Progress Indicator meanwhile Authentication Repository is deciding to show relevant screen.
      home: const Scaffold(
        backgroundColor: LColors.primary,
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
