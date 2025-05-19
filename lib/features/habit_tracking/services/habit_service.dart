import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/habit_item.dart';

class HabitService {
  static final instance = HabitService._();
  final _db = FirebaseFirestore.instance;
  final _uid = FirebaseAuth.instance.currentUser!.uid;

  HabitService._();

  /// Descarga de /action_plans/{low|moderate|high} las secciones con sus
  /// listas de recomendaciones.
  Future<Map<String, List<String>>> fetchDefaultSections(String level) async {
    final doc = await _db
        .collection('action_plans')
        .doc(level)
        .get();
    if (!doc.exists) return {};
    final raw = doc.data()!['sections'] as Map<String, dynamic>;
    return {
      for (final e in raw.entries) 
        e.key: List<String>.from(e.value as List)
    };
  }

  /// Guarda un hábito bajo /users/$_uid/habits/{id}
  Future<void> saveHabit(HabitItem h) {
    return _db
      .collection('users')
      .doc(_uid)
      .collection('habits')
      .doc(h.id)
      .set(h.toJson());
  }

  /// Recupera todos los hábitos del usuario
  Future<List<HabitItem>> fetchUserHabits() async {
    final snap = await _db
      .collection('users')
      .doc(_uid)
      .collection('habits')
      .orderBy('id') // o createdAt si lo añades
      .get();
    return snap.docs
      .map((d) => HabitItem.fromJson(d.data()))
      .toList();
  }

  /// Actualiza sólo el campo isCompleted
  Future<void> toggleCompleted(HabitItem h) {
    return _db
      .collection('users')
      .doc(_uid)
      .collection('habits')
      .doc(h.id)
      .update({'isCompleted': h.isCompleted});
  }

  /// Comprueba si existe el documento, para evitar duplicados
  Future<bool> exists(String id) async {
    final doc = await _db
      .collection('users')
      .doc(_uid)
      .collection('habits')
      .doc(id)
      .get();
    return doc.exists;
  }

   Future<void> deleteHabit(String id) {
    return _db
      .collection('users')
      .doc(_uid)
      .collection('habits')
      .doc(id)
      .delete();
  }
}
