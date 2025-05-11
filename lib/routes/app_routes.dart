import 'package:get/get.dart';
import 'package:gluco_scan/features/authentication/screens/login/login.dart';
import 'package:gluco_scan/features/authentication/screens/signup/signup.dart';
import 'package:gluco_scan/features/authentication/screens/signup/verify_email.dart';
import 'package:gluco_scan/features/authentication/screens/password_configuration/forget_password.dart';

import 'package:gluco_scan/home_page.dart';
import 'package:gluco_scan/routes/routes.dart';


class AppRoutes {
  static final pages = [
    GetPage(name: LRoutes.home, page: () => const HomeScreen()),
    GetPage(name: LRoutes.login, page: () => const LoginScreen()),
    GetPage(name: LRoutes.signUp, page: () => const SignupScreen()),
    GetPage(name: LRoutes.forgotPassword, page: () => const ForgetPasswordScreen()),
    GetPage(name: LRoutes.verifyEmail, page: () => const VerifyEmailScreen()),
  ];
}
