// lib/features/authentication/widgets/l_signup_form.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/common/widgets/inputs/input_field.dart';
import 'package:gluco_scan/features/authentication/controllers/signup/signup_controller.dart';
import 'package:gluco_scan/utils/validators/validation.dart';

/// Formulario de signup con validadores
class LSignupForm extends StatelessWidget {
  const LSignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          LInputField(
            controller: controller.name,
            hintText: 'Tu nombre',
            validator:(value) => LValidator.validateEmptyText('Nombre', value),       // valida que no esté vacío, formato, etc.
          ),
          const SizedBox(height: 16),
          LInputField(
            controller: controller.email,
            hintText: 'Correo electrónico',
            keyboardType: TextInputType.emailAddress,
            validator: (value) => LValidator.validateEmail(value),     // valida formato de email
          ),
          const SizedBox(height: 16),
          LInputField(
            controller: controller.password,
            hintText: 'Contraseña',
            obscureText: true,
            validator: (value) => LValidator.validatePassword(value)  // valida longitud, mayúsculas, etc.
          ),
        ],
      ),
    );
  }
}
