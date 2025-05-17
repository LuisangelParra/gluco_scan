// lib/data/models/user_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gluco_scan/utils/exceptions/exceptions.dart';

class UserModel {
  final String id;
  String name;
  final String email;
  String profilePicture;
  // String medicalHistoryFile; // URL al JSON con la historia clínica

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePicture,
    // required this.medicalHistoryFile,
  });

  /// Modelo vacío para inicializar estados
  static UserModel empty() => UserModel(
        id: '',
        name: '',
        email: '',
        profilePicture: '',
        // medicalHistoryFile: '',
      );

  /// Convierte a JSON para guardar en Firestore
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Email': email,
      'ProfilePicture': profilePicture,
      // 'MedicalHistoryFile': medicalHistoryFile,
    };
  }

  /// Crea un UserModel a partir de un DocumentSnapshot
  factory UserModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    if (data == null) {
      throw const LExceptions('Invalid user document');
    }
    return UserModel(
      id: doc.id,
      name: data['Name'] as String? ?? '',
      email: data['Email'] as String? ?? '',
      profilePicture: data['ProfilePicture'] as String? ?? '',
      // medicalHistoryFile: data['MedicalHistoryFile'] as String? ?? '',
    );
  }
}
