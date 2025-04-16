import 'package:flutter/material.dart';
import 'package:gluco_scan/utils/constants/colors.dart';
import 'package:gluco_scan/utils/constants/image_strings.dart'; // Ajusta el import a tu estructura de proyecto

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fondo blanco
      backgroundColor: LColors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo
              Image.asset(
                LImages.onBoardingLogo,
                width: 200,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 48),

              // Botón "Regístrate"
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Navegar a la pantalla de registro
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LColors.lavenderLight,
                    foregroundColor: LColors.textWhite,
                    elevation: 0,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Regístrate'),
                ),
              ),
              const SizedBox(height: 16),

              // Botón "Iniciar Sesión"
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Navegar a la pantalla de inicio de sesión
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LColors.mint,
                    foregroundColor: LColors.secondary,
                    elevation: 0,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Iniciar Sesión'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
