import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/routes/app_routes.dart';
import 'package:gluco_scan/utils/constants/colors.dart';

// Pantalla principal del Dashboard
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  double? _glucose;
  double? _insulin;
  double? _heartRate;

  Future<void> _showAddDataDialog() async {
    final gController = TextEditingController(text: _glucose?.toString());
    final iController = TextEditingController(text: _insulin?.toString());
    final hController = TextEditingController(text: _heartRate?.toString());
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Añade tus datos'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDataField('Glucosa (mmol/L)', gController),
              const SizedBox(height: 12),
              _buildDataField('Insulina (mg/dL)', iController),
              const SizedBox(height: 12),
              _buildDataField('Ritmo cardíaco (bpm)', hController),
            ],
          ),
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _glucose = double.tryParse(gController.text);
                _insulin = double.tryParse(iController.text);
                _heartRate = double.tryParse(hController.text);
              });
              Navigator.pop(context);
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  Widget _buildDataField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Valores de salud (sólo para demostración, se actualizarán desde datos reales)
    final double glucoseVal = _glucose ?? 0.0;
    final double insulinVal = _insulin ?? 0.0;
    final double hrVal = _heartRate ?? 0.0;

    // Normalizar y calcular progreso promedio
    final double progress = ((glucoseVal / 10) + (insulinVal / 200) + (hrVal / 120)) / 3;

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
                    value: progress.clamp(0.0, 1.0),
                    minHeight: 12,
                    backgroundColor: LColors.lavenderLight,
                    valueColor: const AlwaysStoppedAnimation(LColors.primary),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tu progreso es de ${(progress * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(
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
            // 4) Ingresos diarios - nueva distribución
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tarjeta grande para añadir datos
                SizedBox(
                  width: double.infinity,
                  child: _DashboardCard(
                    backgroundColor: LColors.primary,
                    icon: Icons.add,
                    iconColor: Colors.white,
                    title: 'Añade tus datos',
                    titleColor: Colors.white,
                    onTap: _showAddDataDialog,
                  ),
                ),
                const SizedBox(height: 12),
                // Tres tarjetas métricas en una fila
                Row(
                  children: [
                    Expanded(
                      child: _DashboardCard(
                        backgroundColor: LColors.accent.withOpacity(0.3),
                        icon: Icons.bloodtype,
                        iconColor: LColors.darkBlue,
                        title: 'Glucosa',
                        titleColor: LColors.darkBlue,
                        subtitle: _glucose != null ? '${_glucose!.toStringAsFixed(1)} mmol/L' : '--.-- mmol/L',
                        subtitleColor: LColors.darkBlue.withOpacity(0.7),
                        onTap: _showAddDataDialog,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _DashboardCard(
                        backgroundColor: LColors.blush,
                        icon: Icons.opacity,
                        iconColor: LColors.darkBlue,
                        title: 'Insulina',
                        titleColor: LColors.darkBlue,
                        subtitle: _insulin != null ? '${_insulin!.toStringAsFixed(0)} mg/dL' : '--.-- mg/dL',
                        subtitleColor: LColors.darkBlue.withOpacity(0.7),
                        onTap: _showAddDataDialog,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _DashboardCard(
                        backgroundColor: LColors.mint,
                        icon: Icons.favorite,
                        iconColor: Colors.white,
                        title: 'Ritmo cardíaco',
                        titleColor: Colors.white,
                        subtitle: _heartRate != null ? '${_heartRate!.toStringAsFixed(0)} bpm' : '--.-- bpm',
                        subtitleColor: Colors.white70,
                        onTap: _showAddDataDialog,
                      ),
                    ),
                  ],
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
                  onTap: () => Get.toNamed(AppRoutes.riskResult),
                ),
                _DashboardCard(
                  backgroundColor: LColors.accent,
                  icon: Icons.event_note,
                  iconColor: Colors.white,
                  title: 'Plan de\nacción',
                  titleColor: Colors.white,
                  onTap: () => Get.toNamed(AppRoutes.actionPlan),
                ),
                _DashboardCard(
                  backgroundColor: LColors.blush,
                  icon: Icons.track_changes,
                  iconColor: LColors.darkBlue,
                  title: 'Registrar mis\nhábitos',
                  titleColor: LColors.darkBlue,
                  onTap: () => Get.toNamed(AppRoutes.habitTracking),
                ),
                _DashboardCard(
                  backgroundColor: LColors.lavenderLight,
                  icon: Icons.menu_book,
                  iconColor: LColors.darkBlue,
                  title: 'Aprender sobre\nla diabetes',
                  titleColor: LColors.darkBlue,
                  onTap: () => Get.toNamed(AppRoutes.learning),
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
      elevation: 4,
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
              Icon(icon, size: 32, color: iconColor),
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