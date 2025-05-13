import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/utils/constants/colors.dart';
import 'package:iconsax/iconsax.dart';
import 'package:gluco_scan/features/authentication/controllers/login/login_controller.dart';
import 'package:gluco_scan/utils/validators/validation.dart';

/// Campos de email y contraseña.
class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    return Form(
      key: controller.loginFormKey,
      child: Column(
        children: [
          TextFormField(
                controller: controller.email,
                validator: (value) => LValidator.validateEmail(value),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right, color: LColors.textWhite,),
                  labelText: "Correo electrónico",
            ),
          ),
          const SizedBox(height: 16),
          Obx(
                () => TextFormField(
                  controller: controller.password,
                  validator: (value) =>
                      LValidator.validateEmptyText('Password', value),
                  obscureText: controller.hidePassword.value,
                  decoration: InputDecoration(
                    labelText: "Contraseña",
                    prefixIcon: const Icon(Iconsax.password_check, color: LColors.textWhite,),
                    suffixIcon: IconButton(
                      onPressed: () => controller.hidePassword.value =
                          !controller.hidePassword.value,
                      icon: Icon(controller.hidePassword.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye, color: LColors.textWhite,),
                    ),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
