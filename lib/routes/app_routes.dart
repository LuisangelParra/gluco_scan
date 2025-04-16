import 'package:get/get.dart';
import 'package:gluco_scan/home_page.dart';
import 'package:gluco_scan/routes/routes.dart';


class AppRoutes {
  static final pages = [
    GetPage(name: LRoutes.home, page: () => const HomeScreen()),
  ];
}
