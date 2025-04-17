import 'package:get/get.dart';
import 'package:gluco_scan/features/authentication/screens/login/login.dart';
import 'package:gluco_scan/features/authentication/screens/signup/signup.dart';
import 'package:gluco_scan/home_page.dart';
import 'package:gluco_scan/routes/routes.dart';


class AppRoutes {
  static final pages = [
    GetPage(name: LRoutes.home, page: () => const HomeScreen()),
    GetPage(name: LRoutes.login, page: () => const LoginScreen()),
    GetPage(name: LRoutes.signUp, page: () => const SignupScreen()),
  ];
}
