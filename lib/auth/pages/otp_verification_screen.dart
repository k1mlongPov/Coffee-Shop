import 'package:coffeeshop/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OTPVerificationScreen extends StatelessWidget {
  final otpController = TextEditingController();

  final authController = Get.find<AuthController>();

  OTPVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify OTP")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Enter OTP",
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => authController.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        authController.verifyOTP(otpController.text.trim());
                      },
                      child: const Text('Verify'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
