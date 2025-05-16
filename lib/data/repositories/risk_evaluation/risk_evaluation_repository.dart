// lib/features/risk_evaluation/repositories/risk_evaluation_repository.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class RiskEvaluationRepository {
  final http.Client _client;
  RiskEvaluationRepository([http.Client? client]) : _client = client ?? http.Client();

  Future<Map<String, dynamic>> predict(Map<String, dynamic> payload) async {
    final uri = Uri.parse("https://diabetes-detection-model-api.onrender.com/predict");
    final resp = await _client.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: json.encode(payload),
    );
    if (resp.statusCode == 200) {
      return json.decode(resp.body) as Map<String, dynamic>;
    } else {
      throw Exception("API error ${resp.statusCode}");
    }
  }
}
