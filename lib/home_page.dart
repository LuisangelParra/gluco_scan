// lib/features/home/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:gluco_scan/data/repositories/authentication/authentication_repository.dart';
import 'package:gluco_scan/utils/popups/loaders.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.onThemeChanged});

  final VoidCallback? onThemeChanged;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _authRepo = AuthenticationRepository.instance;

  Future<void> _logout() async {
    try {
      // Opcional: mostrar loader si gustas
      LLoaders.customToast(message: 'Cerrando sesión...');
      await _authRepo.logout();
    } catch (e) {
      LLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GlucoScan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: _logout,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.onThemeChanged,
        child: const Icon(Icons.color_lens),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Hello, World!'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Elevated Button'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {},
              child: const Text('Text Button'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Outlined Button'),
            ),
            const SizedBox(height: 16),
            Switch.adaptive(
              value: false,
              onChanged: (v) {},
            ),
          ],
        ),
      ),
    );
  }
}
