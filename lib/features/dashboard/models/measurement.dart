// lib/features/dashboard/models/measurement_model.dart
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

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp.toIso8601String(),
        'glucose': glucose,
        'insulin': insulin,
        'heartRate': heartRate,
      };

  factory MeasurementModel.fromJson(Map<String, dynamic> json) {
    return MeasurementModel(
      timestamp: DateTime.parse(json['timestamp'] as String),
      glucose: (json['glucose'] as num).toDouble(),
      insulin: (json['insulin'] as num).toDouble(),
      heartRate: (json['heartRate'] as num).toDouble(),
    );
  }
}
