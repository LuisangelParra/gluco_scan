// lib/features/dashboard/widgets/dashboard_header.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/features/personalization/controllers/user_controller.dart';
import '../../../routes/routes.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class DashboardHeader extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  const DashboardHeader({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    final userCtrl = Get.find<UserController>();
    return Container(
      decoration: const BoxDecoration(
        color: LColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(LSizes.cardRadiusLg),
          bottomRight: Radius.circular(LSizes.cardRadiusLg),
        ),
      ),
      padding: const EdgeInsets.only(
        top: 40,
        left: LSizes.lg,
        right: LSizes.lg,
      ),
      child: Row(
        children: [
          // Saludo y subtítulo
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '⭐ Buen día, $userName',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: LSizes.sm),
                const Text(
                  '¡Aquí está tu progreso de salud!',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Botón Cerrar sesión
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: 'Cerrar sesión',
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              // Navegar al login y eliminar historial
              Get.offAllNamed(LRoutes.login);
            },
          ),

          // Avatar (puede usarse para ir al perfil)
          // Avatar: abre pantalla de perfil
          Obx(() {
            final url = userCtrl.user.value.profilePicture;
            return GestureDetector(
              onTap: () => Get.toNamed(LRoutes.profile),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                backgroundImage: url.isNotEmpty
                  ? NetworkImage(url) as ImageProvider
                  : null,
                child: url.isEmpty
                  ? const Icon(Icons.person, color: LColors.primary)
                  : null,
              ),
            );
          }),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}
