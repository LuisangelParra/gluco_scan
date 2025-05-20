// lib/data/repositories/measurement_repository.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/features/dashboard/models/measurement.dart';
import 'package:gluco_scan/data/repositories/authentication/authentication_repository.dart';

class MeasurementRepository extends GetxService {
  static MeasurementRepository get instance => Get.find();
  final _firestore = FirebaseFirestore.instance;

  Future<void> save(MeasurementModel m) async {
    final uid = AuthenticationRepository.instance.authUser!.uid;
    // Guardamos la fecha como Timestamp para poder filtrar después
    await _firestore
      .collection('Users')
      .doc(uid)
      .collection('Measurements')
      .add({
        'glucose': m.glucose,
        'insulin': m.insulin,
        'heartRate': m.heartRate,
        'timestamp': Timestamp.fromDate(m.timestamp),
      });
  }

  Future<MeasurementModel?> fetchLast() async {
    final uid = AuthenticationRepository.instance.authUser!.uid;
    final snap = await _firestore
        .collection('Users')
        .doc(uid)
        .collection('Measurements')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();
    if (snap.docs.isEmpty) return null;
    return MeasurementModel.fromJson(snap.docs.first.data());
  }

  /// Nuevo: trae todas las mediciones desde [since]
  Future<List<MeasurementModel>> fetchSince(DateTime since) async {
    final uid = AuthenticationRepository.instance.authUser!.uid;
    final snap = await _firestore
        .collection('Users')
        .doc(uid)
        .collection('Measurements')
        .where('timestamp', isGreaterThanOrEqualTo: Timestamp.fromDate(since))
        .get();
    return snap.docs
        .map((d) => MeasurementModel.fromJson(d.data()))
        .toList();
  }
}
