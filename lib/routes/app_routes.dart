// 2) lib/routes/app_routes.dart

import 'package:get/get.dart';
import 'package:gluco_scan/features/dashboard/screens/dashboard_screen.dart';
import 'package:gluco_scan/features/authentication/screens/onboarding/onboarding.dart';
import 'package:gluco_scan/features/authentication/screens/login/login.dart';
import 'package:gluco_scan/features/authentication/screens/signup/signup.dart';
import 'package:gluco_scan/features/risk_evaluation/screens/risk_evaluation_screen.dart';

class AppRoutes {
  static const welcome   = '/welcome';
  static const login     = '/login';
  static const signup    = '/signup';
  static const dashboard = '/dashboard';
  static const riskEval = '/risk-evaluation';

  static final pages = <GetPage>[
    GetPage(name: welcome,  page: () => const OnBoardingScreen()),
    GetPage(name: login,    page: () => const LoginScreen()),
    GetPage(name: signup,   page: () => const SignupScreen()),
    GetPage(name: dashboard, page: () => const DashboardScreen()),
    GetPage(name: riskEval, page: () => const RiskEvaluationScreen()),
  ];
}