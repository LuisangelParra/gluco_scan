// lib/features/dashboard/models/measurement.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class Measurement {
  final String id;
  final DateTime timestamp;
  final double glucose;
  final double insulin;
  final double heartRate;

  Measurement({
    required this.id,
    required this.timestamp,
    required this.glucose,
    required this.insulin,
    required this.heartRate,
  });

  factory Measurement.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> doc) {
    final d = doc.data()!;
    return Measurement(
      id: doc.id,
      timestamp: (d['timestamp'] as Timestamp).toDate(),
      glucose: (d['glucose'] as num).toDouble(),
      insulin: (d['insulin'] as num).toDouble(),
      heartRate: (d['heartRate'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'timestamp': Timestamp.fromDate(timestamp),
        'glucose': glucose,
        'insulin': insulin,
        'heartRate': heartRate,
      };
}
