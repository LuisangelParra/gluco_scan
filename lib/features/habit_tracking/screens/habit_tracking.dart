// lib/features/habit_tracking/screens/habit_tracking_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/routes.dart';
import '../controllers/habit_tracking_controller.dart';
import '../widgets/habit_tracking_header.dart';
import '../widgets/habit_tip_card.dart';
import '../widgets/habit_category_filter.dart';
import '../widgets/habit_card.dart';
import '../widgets/add_habit_button.dart';

class HabitTrackingScreen extends StatelessWidget {
  const HabitTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Inyecta el controller (lazyPut en bindings o aquí)
    final ctrl = Get.put(HabitTrackingController());

    return Scaffold(
      backgroundColor: const Color(0xFF6665A9),
      appBar: const HabitTrackingHeader(),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Text(
                'Visualiza y administra tus hábitos diarios de forma clara y motivadora.',
                style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const HabitTipCard('Dormir al menos 7 horas mejora tu salud mental y física.'),
                    const HabitCategoryFilter(),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Obx(() {
                        final list = ctrl.filteredHabits;
                        if (list.isEmpty) {
                          return const Center(
                            child: Text(
                              'No hay hábitos en esta categoría',
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (_, i) => HabitCard(list[i]),
                        );
                      }),
                    ),
                    const AddHabitButton(),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () => Get.toNamed(LRoutes.learning),
        label: const Text('¡Aprende!', style: TextStyle(color: Color(0xFF5956A6), fontWeight: FontWeight.bold, fontSize: 15)),
      ),
    );
  }
}
