import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/features/risk_evaluation/screens/action_plan_screen.dart';

void main() {
  setUp(() => Get.testMode = true);

  testWidgets('Muestra advertencia cuando el riesgo es Alto', (WidgetTester tester) async {
    // Configura el test en modo GetX y pasa el parámetro
    Get.parameters = {'clasificacion': 'Alto'};

    // Construye la app con la pantalla bajo test
    await tester.pumpWidget(
      GetMaterialApp(
        home: Builder(
          builder: (_) => const ActionPlanScreen(),
        ),
      ),
    );

    // Espera a que se renderice
    await tester.pumpAndSettle();

    // Verifica la advertencia y el ícono
    expect(
      find.textContaining('requiere atención prioritaria'),
      findsOneWidget,
    );
    expect(
      find.byIcon(Icons.warning_amber_rounded),
      findsOneWidget,
    );
  });
}
