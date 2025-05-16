import 'package:get/get.dart';
import 'package:gluco_scan/features/authentication/screens/login/login.dart';
import 'package:gluco_scan/features/authentication/screens/signup/signup.dart';
import 'package:gluco_scan/features/authentication/screens/signup/verify_email.dart';
import 'package:gluco_scan/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:gluco_scan/features/dashboard/screen/dashboard.dart';
import 'package:gluco_scan/features/habit_tracking/screens/habit_tracking.dart';
import 'package:gluco_scan/features/learning/screens/learning.dart';
import 'package:gluco_scan/features/risk_evaluation/screens/action_plan.dart';
import 'package:gluco_scan/features/risk_evaluation/screens/risk_evaluation.dart';
import 'package:gluco_scan/features/risk_evaluation/screens/risk_result.dart';

import 'package:gluco_scan/home_page.dart';
import 'package:gluco_scan/routes/routes.dart';


class AppRoutes {
  static final pages = <GetPage>[
    GetPage(name: LRoutes.home, page: () => const HomeScreen()),
    GetPage(name: LRoutes.login, page: () => const LoginScreen()),
    GetPage(name: LRoutes.signUp, page: () => const SignupScreen()),
    GetPage(name: LRoutes.forgotPassword, page: () => const ForgetPasswordScreen()),
    GetPage(name: LRoutes.verifyEmail, page: () => const VerifyEmailScreen()),
    GetPage(name: LRoutes.dashboard, page: () => const DashboardScreen()),
    GetPage(name: LRoutes.riskEval, page: () => const RiskEvaluationScreen()),
    GetPage(name: LRoutes.riskResult, page: () => const RiskResultScreen()),
    GetPage(name: LRoutes.actionPlan, page: () => const ActionPlanScreen()),
    GetPage(name: LRoutes.habitTracking, page: () => const HabitTrackingScreen()),
    GetPage(name: LRoutes.learning, page: () => const LearningScreen()),
  ];
}
