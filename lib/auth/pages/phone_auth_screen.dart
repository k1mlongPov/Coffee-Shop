import 'package:coffeeshop/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneAuthScreen extends StatelessWidget {
  final AuthController controller = Get.put(AuthController());
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  PhoneAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Phone Authentication")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: phoneController,
            decoration: const InputDecoration(labelText: "Enter Phone Number"),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 20),
          Obx(() {
            return controller.verificationId.isEmpty
                ? ElevatedButton(
                    onPressed: () {
                      //controller.sendOTP(phoneController.text);
                    },
                    child: const Text("Send OTP"),
                  )
                : Column(
                    children: [
                      TextField(
                        controller: otpController,
                        decoration:
                            const InputDecoration(labelText: "Enter OTP"),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          //controller.verifyOTP(otpController.text);
                        },
                        child: const Text("Verify OTP"),
                      ),
                    ],
                  );
          }),
        ],
      ),
    );
  }
}
