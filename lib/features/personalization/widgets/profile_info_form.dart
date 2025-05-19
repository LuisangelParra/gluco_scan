// lib/features/personalization/widgets/profile_info_form.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../controllers/user_controller.dart';

class ProfileInfoForm extends StatefulWidget {
  const ProfileInfoForm({super.key});

  @override
  State<ProfileInfoForm> createState() => _ProfileInfoFormState();
}

class _ProfileInfoFormState extends State<ProfileInfoForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  final userCtrl = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: userCtrl.user.value.name);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _saveName() async {
    if (!_formKey.currentState!.validate()) return;
    final newName = _nameCtrl.text.trim();
    if (newName == userCtrl.user.value.name) return;

    try {
      await userCtrl.userRepository.updateSingleField({'name': newName});
      userCtrl.user.update((u) => u?.name = newName);
      Get.snackbar(
        'Guardado',
        'Nombre actualizado',
        backgroundColor: LColors.primary,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar('Error', 'No se pudo actualizar nombre');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = userCtrl.user.value;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Correo (solo lectura)
          TextFormField(
            initialValue: user.email,
            enabled: false,
            decoration: const InputDecoration(
              labelText: 'Correo',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: LSizes.md),

          // Nombre
          TextFormField(
            controller: _nameCtrl,
            decoration: const InputDecoration(
              labelText: 'Nombre',
              border: OutlineInputBorder(),
            ),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Ingrese nombre' : null,
          ),
          const SizedBox(height: LSizes.md),

          // Botón guardar
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saveName,
              child: const Text('Guardar cambios'),
            ),
          ),
        ],
      ),
    );
  }
}
