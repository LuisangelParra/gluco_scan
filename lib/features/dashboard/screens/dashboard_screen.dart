import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/routes/app_routes.dart';
import 'package:gluco_scan/utils/constants/colors.dart';

// Pantalla principal del Dashboard
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ════════════════════════════════════════════════════════════
      // 1) HEADER MORADO con bordes inferiores redondeados
      // ════════════════════════════════════════════════════════════
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Container(
          decoration: const BoxDecoration(
            color: LColors.primary,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          padding: const EdgeInsets.only(top: 40, left: 40, right: 40),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Saludo
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      '⭐ Buen día, Luis',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '¡Aquí está tu progreso de salud!',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              // Icono de ajustes (gear)
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.settings, color: Colors.white),
              ),

              // Avatar de usuario
              const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: LColors.primary),
              ),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 25, left: 16, right: 16),
        child: Column(
          children: [
            // ════════════════════════════════════════════════════════════
            // 2) MOOD ICON
            // ════════════════════════════════════════════════════════════
            CircleAvatar(
              radius: 40,
              backgroundColor: LColors.blush,
              child: const Icon(
                Icons.sentiment_satisfied_outlined,
                size: 48,
                color: LColors.primary,
              ),
            ),
            const SizedBox(height: 16),

            // ════════════════════════════════════════════════════════════
            // 3) BARRA DE PROGRESO + TEXTO
            // ════════════════════════════════════════════════════════════
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: 0.64,
                    minHeight: 12,
                    backgroundColor: LColors.lavenderLight,
                    valueColor: const AlwaysStoppedAnimation(LColors.primary),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Tu progreso es de 64%',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '¡Mantén tu progreso al día!',
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ════════════════════════════════════════════════════════════
            // 4) INGRESOS DIARIOS (Grid 2x2)
            // ════════════════════════════════════════════════════════════
            _SectionTitle('Ingresos diarios'),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 4,
              childAspectRatio: 0.6,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // 1️⃣ Añade tus datos (oscuro → texto blanco)
                _DashboardCard(
                  backgroundColor: LColors.primary,
                  icon: Icons.add,
                  iconColor: Colors.white,
                  title: 'Añade tus datos',
                  titleColor: Colors.white,
                  onTap: () {},
                ),

                // 2️⃣ Glucosa en sangre (pastel claro → texto oscuro)
                _DashboardCard(
                  // ignore: deprecated_member_use
                  backgroundColor: LColors.accent.withOpacity(0.3),
                  icon: Icons.bloodtype,
                  iconColor: LColors.darkBlue,
                  title: 'Glucosa en\nsangre',
                  titleColor: LColors.darkBlue,
                  subtitle: '5.1 mmol/L',
                  // ignore: deprecated_member_use
                  subtitleColor: LColors.darkBlue.withOpacity(0.7),
                  onTap: () {},
                ),

                // 3️⃣ Insulina (rosa claro → texto oscuro)
                _DashboardCard(
                  backgroundColor: LColors.blush,
                  icon: Icons.opacity,
                  iconColor: LColors.darkBlue,
                  title: 'Insulina',
                  titleColor: LColors.darkBlue,
                  subtitle: '100 mg/dl',
                  // ignore: deprecated_member_use
                  subtitleColor: LColors.darkBlue.withOpacity(0.7),
                  onTap: () {},
                ),

                // 4️⃣ Ritmo cardíaco (menta oscuro → texto blanco)
                _DashboardCard(
                  backgroundColor: LColors.mint,
                  icon: Icons.favorite,
                  iconColor: Colors.white,
                  title: 'Ritmo\ncardíaco',
                  titleColor: Colors.white,
                  subtitle: '78 bpm',
                  subtitleColor: Colors.white70,
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 32),

            // ════════════════════════════════════════════════════════════
            // 5) CONTROL Y MONITOREO (Grid 2x3)
            // ════════════════════════════════════════════════════════════
            _SectionTitle('Control y monitoreo'),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _DashboardCard(
                  backgroundColor: LColors.primary,
                  icon: Icons.health_and_safety,
                  iconColor: Colors.white,
                  title: 'Evaluar mi\nriesgo',
                  titleColor: Colors.white,
                  onTap: () => Get.toNamed(AppRoutes.riskEval),
                ),
                _DashboardCard(
                  backgroundColor: LColors.mint,
                  icon: Icons.show_chart,
                  iconColor: Colors.white,
                  title: 'Nivel de\nriesgo',
                  titleColor: Colors.white,
                  onTap: () {},
                ),
                _DashboardCard(
                  backgroundColor: LColors.accent,
                  icon: Icons.event_note,
                  iconColor: Colors.white,
                  title: 'Plan de\nacción',
                  titleColor: Colors.white,
                  onTap: () {},
                ),
                _DashboardCard(
                  backgroundColor: LColors.blush,
                  icon: Icons.track_changes,
                  iconColor: LColors.darkBlue,
                  title: 'Registrar mis\nhábitos',
                  titleColor: LColors.darkBlue,
                  onTap: () {},
                ),
                _DashboardCard(
                  backgroundColor: LColors.lavenderLight,
                  icon: Icons.menu_book,
                  iconColor: LColors.darkBlue,
                  title: 'Aprender sobre\nla diabetes',
                  titleColor: LColors.darkBlue,
                  onTap: () {},
                ),
                _DashboardCard(
                  backgroundColor: LColors.cream,
                  icon: Icons.update,
                  iconColor: LColors.darkBlue,
                  title: 'Actualizar\nmis datos',
                  titleColor: LColors.darkBlue,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Título de sección (alineado a la izquierda)
class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

/// Tarjeta genérica con icono y texto. 
/// Permite personalizar colores de fondo, icono, título y subtítulo.
class _DashboardCard extends StatelessWidget {
  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;
  final String title;
  final Color titleColor;
  final String? subtitle;
  final Color? subtitleColor;
  final VoidCallback onTap;

  const _DashboardCard({
    required this.backgroundColor,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.titleColor,
    this.subtitle,
    this.subtitleColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 24, color: iconColor),
              const SizedBox(height: 4),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(color: titleColor, fontWeight: FontWeight.bold),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: subtitleColor ?? titleColor, fontSize: 12),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}