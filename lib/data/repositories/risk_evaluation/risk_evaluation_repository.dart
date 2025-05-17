import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class RiskEvaluationRepository {
  final _firestore = FirebaseFirestore.instance;
  final _auth      = FirebaseAuth.instance;

  /// Llama a la API y registra 
  /// el payload + result en Firestore
  Future<Map<String, dynamic>> predict(Map<String, dynamic> payload) async {
    final response = await http.post(
      Uri.parse("https://diabetes-detection-model-api.onrender.com/predict"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(payload),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al obtener resultado: ${response.statusCode}');
    }
    final result = json.decode(response.body) as Map<String, dynamic>;

    // Guarda en Firestore bajo Users/{uid}/RiskEvaluations/
    final uid = _auth.currentUser!.uid;
    await _firestore
      .collection('Users')
      .doc(uid)
      .collection('RiskEvaluations')
      .add({
        'payload': payload,
        'result': result,
        'timestamp': FieldValue.serverTimestamp(),
      });

    return result;
  }
}
