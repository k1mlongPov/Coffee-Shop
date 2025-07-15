// phone_login_screen.dart
import 'package:coffeeshop/auth/controllers/auth_controller.dart';
import 'package:coffeeshop/auth/widgets/phone_widget.dart';
import 'package:coffeeshop/auth/widgets/textfield_input.dart';
import 'package:coffeeshop/home/widgets/reusable_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PhoneAuthScreen extends StatelessWidget {
  final phoneController = TextEditingController();
  final authController = Get.put(AuthController());

  PhoneAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          clipPathWidgetForPhone(
            'Welcome!',
            'Phone Login',
            'Login with Phone number',
          ),
          SizedBox(height: 30.h),
          Divider(
            height: 2.h,
            thickness: 5.w,
            color: brownColor,
            endIndent: 190.w,
            indent: 35.w,
          ),
          SizedBox(height: 30.h),
          Padding(
            padding: EdgeInsets.all(30.r),
            child: TextFieldInput(
              textEditingController: phoneController,
              hintText: "0883456789",
              labelText: "Enter Phone Number",
              keyboardType: TextInputType.number,
              prefixIcon: Icons.phone,
            ),
          ),
          SizedBox(height: 20.h),
          Obx(
            () => authController.isLoading.value
                ? const CircularProgressIndicator()
                : GestureDetector(
                    onTap: () {
                      authController.signInWithPhone(
                        authController.formatToE164(
                          phoneController.text.trim(),
                        ),
                      );
                    },
                    child: reusableBtn(
                      'sendOTP',
                      'Send OTP',
                      whiteColor,
                      brownColor,
                      40.h,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
