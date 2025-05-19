// lib/features/habit_tracking/controllers/habit_tracking_controller.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../models/habit_item.dart';

class HabitTrackingController extends GetxController {
  /// Permite acceder a la misma instancia desde otros sitios
  static HabitTrackingController get instance => Get.put(HabitTrackingController());

  final _firestore = FirebaseFirestore.instance;
  final _uid       = FirebaseAuth.instance.currentUser!.uid;

  /// Lista maestra de hábitos
  final allHabits      = <HabitItem>[].obs;

  /// Lista filtrada según categoría
  final filteredHabits = <HabitItem>[].obs;

  /// 'all', 'activity', 'nutrition' o 'sleep'
  final selectedCategory = 'all'.obs;

  @override
  void onInit() {
    super.onInit();
    // Carga inicial y refiltra cada vez que cambian allHabits o selectedCategory
    _loadHabits();
    ever(allHabits, (_) => _applyFilter());
    ever(selectedCategory, (_) => _applyFilter());
  }

  /// 1) Carga todos los hábitos del usuario desde Firestore
  Future<void> _loadHabits() async {
    final snap = await _firestore
        .collection('Users')
        .doc(_uid)
        .collection('Habits')
        .get();
    final items = snap.docs.map((d) {
      final data = d.data();
      return HabitItem.fromJson({
        ...data,
        'id': d.id,
      });
    }).toList();
    allHabits.assignAll(items);
  }

  /// 2) Refiltra según la categoría seleccionada
  void _applyFilter() {
    if (selectedCategory.value == 'all') {
      filteredHabits.assignAll(allHabits);
    } else {
      filteredHabits.assignAll(
        allHabits.where((h) => h.category == selectedCategory.value),
      );
    }
  }

  /// 3) Cambia la categoría para el filtro
  void toggleCategory(String cat) {
    selectedCategory.value = cat;
  }

  /// 4) Asigna los hábitos recomendados para el nivel de riesgo
  Future<void> assignHabitsForRisk(String riesgo) async {
    // mapea "Alta"/"Moderada"/"Baja" → docId "high"/"moderate"/"low"
    final level = riesgo.toLowerCase() == 'alta'
        ? 'high'
        : riesgo.toLowerCase() == 'moderada'
            ? 'moderate'
            : 'low';

    final doc = await _firestore.collection('action_plans').doc(level).get();
    if (!doc.exists) return;

    final sections = Map<String, dynamic>.from(doc.data()!['sections'] as Map);
    final nuevos = <HabitItem>[];

    // construye la lista plana de HabitItem
    sections.forEach((seccion, lista) {
      final cat = _categoryFromSection(seccion);
      for (var i = 0; i < (lista as List).length; i++) {
        final text = lista[i] as String;
        nuevos.add(HabitItem(
          id: '${level}_${seccion}_$i',
          title: text,
          subtitle: seccion,
          category: cat,
          icon: HabitItem.iconForCategory(cat),
          backgroundColor: HabitItem.bgColorForCategory(cat),
          iconColor: HabitItem.iconColorForCategory(cat),
        ));
      }
    });

    // refresca Firestore: borra viejos y sube nuevos
    final batch = _firestore.batch();
    final ref = _firestore.collection('Users').doc(_uid).collection('Habits');
    final existentes = await ref.get();
    for (var d in existentes.docs) {
      batch.delete(d.reference);
    }
    for (var h in nuevos) {
      batch.set(ref.doc(h.id), h.toJson());
    }
    await batch.commit();

    // actualiza la lista local
    allHabits.assignAll(nuevos);
  }

  /// 5) Añade un hábito personalizado
  void addHabit(String title, String category, String quantity) {
    final docRef = _firestore
        .collection('Users')
        .doc(_uid)
        .collection('Habits')
        .doc();
    final id = docRef.id;

    final habit = HabitItem(
      id: id,
      title: title,
      subtitle: quantity,
      category: category,
      icon: HabitItem.iconForCategory(category),
      backgroundColor: HabitItem.bgColorForCategory(category),
      iconColor: HabitItem.iconColorForCategory(category),
      isCompleted: false,
      quantity: quantity,
    );

    allHabits.add(habit);
    docRef.set(habit.toJson());
  }

  /// 6) Marca o desmarca un hábito como completado
  void toggleComplete(HabitItem habit) {
    final idx = allHabits.indexWhere((h) => h.id == habit.id);
    if (idx == -1) return;
    habit.isCompleted = !habit.isCompleted;
    allHabits[idx] = habit;

    _firestore
        .collection('Users')
        .doc(_uid)
        .collection('Habits')
        .doc(habit.id)
        .update({'isCompleted': habit.isCompleted});
  }

  /// Alias para que HabitCard y HabitDetailSheet puedan llamar cualquiera
  void toggleCompleted(HabitItem habit) => toggleComplete(habit);

  /// 7) Elimina un hábito
  void removeHabit(HabitItem habit) {
    allHabits.removeWhere((h) => h.id == habit.id);
    _firestore
        .collection('Users')
        .doc(_uid)
        .collection('Habits')
        .doc(habit.id)
        .delete();
  }

  /// Helper: mapea nombre de sección ↔ categoría interna
  String _categoryFromSection(String s) {
    switch (s.toLowerCase()) {
      case 'alimentación':
        return 'nutrition';
      case 'ejercicio':
        return 'activity';
      case 'hábitos de sueño':
        return 'sleep';
      default:
        return 'other';
    }
  }
}
