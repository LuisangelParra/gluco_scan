// lib/features/dashboard/repositories/measurement_repository.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gluco_scan/features/dashboard/models/measurement.dart';
import 'package:gluco_scan/data/repositories/authentication/authentication_repository.dart';

class MeasurementRepository {
  final _db = FirebaseFirestore.instance;
  final _userId = AuthenticationRepository.instance.authUser!.uid;

  Future<void> saveMeasurement(Measurement m) {
    return _db
        .collection('users')
        .doc(_userId)
        .collection('measurements')
        .add(m.toJson());
  }

  /// Solo las de hoy
  Stream<List<Measurement>> streamToday() {
    final start = DateTime.now();
    final todayStart = DateTime(start.year, start.month, start.day);
    return _db
        .collection('users')
        .doc(_userId)
        .collection('measurements')
        .where('timestamp', isGreaterThanOrEqualTo: todayStart)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map(Measurement.fromSnapshot).toList());
  }
}
