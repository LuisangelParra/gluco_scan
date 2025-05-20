// lib/features/dashboard/models/measurement.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class MeasurementModel {
  final DateTime timestamp;
  final double glucose;
  final double insulin;
  final double heartRate;

  MeasurementModel({
    required this.timestamp,
    required this.glucose,
    required this.insulin,
    required this.heartRate,
  });

  factory MeasurementModel.fromJson(Map<String, dynamic> json) {
    final rawTs = json['timestamp'];
    DateTime ts;
    if (rawTs is Timestamp) {
      ts = rawTs.toDate();
    } else if (rawTs is String) {
      ts = DateTime.parse(rawTs);
    } else if (rawTs is int) {
      ts = DateTime.fromMillisecondsSinceEpoch(rawTs);
    } else {
      // Por si viene otro tipo inesperado
      ts = DateTime.now();
    }

    return MeasurementModel(
      timestamp: ts,
      glucose: (json['glucose'] as num?)?.toDouble() ?? 0.0,
      insulin: (json['insulin'] as num?)?.toDouble() ?? 0.0,
      heartRate: (json['heartRate'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
        // Al guardar usa Timestamp, para luego recuperarlo bien
        'timestamp': Timestamp.fromDate(timestamp),
        'glucose': glucose,
        'insulin': insulin,
        'heartRate': heartRate,
      };
}
