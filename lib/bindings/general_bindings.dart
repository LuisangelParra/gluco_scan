import 'package:get/get.dart';
import 'package:gluco_scan/utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    
    Get.put(NetworkManager());
  }
}
