// phone_login_screen.dart
import 'package:coffeeshop/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneAuthScreen extends StatelessWidget {
  final phoneController = TextEditingController();
  final authController = Get.put(AuthController());

  PhoneAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phone Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Enter phone number",
                hintText: "+85512345678",
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => authController.isLoading.value
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        authController.signInWithPhone(
                            authController.formatToE164(phoneController.text));
                      },
                      child: const Text('Send OTP'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
