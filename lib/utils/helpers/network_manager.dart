import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/utils/popups/loaders.dart';

class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late final StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  @override
  void onInit() {
    super.onInit();
    // Mapeamos la lista que emite el stream y tomamos always el primer elemento
    _connectivitySubscription = _connectivity.onConnectivityChanged
      .map((list) => list.first)         // List<ConnectivityResult> → ConnectivityResult
      .distinct()                        // opcional: solo cambios reales
      .listen(_updateConnectionStatus);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult status) async {
    _connectionStatus.value = status;
    if (status == ConnectivityResult.none) {
      LLoaders.customToast(message: 'No Internet Connection');
    }
  }

  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      return result != ConnectivityResult.none;
    } on PlatformException {
      return false;
    }
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}
