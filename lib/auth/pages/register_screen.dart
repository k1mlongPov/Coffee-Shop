import 'package:coffeeshop/auth/controller/auth_controller.dart';
import 'package:coffeeshop/auth/widgets/register_widget.dart';
import 'package:coffeeshop/auth/widgets/textfield_input.dart';
import 'package:coffeeshop/home/widgets/reusable_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final authController = Get.put(AuthController());
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 670));
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            clipPathWidgetForRegister(
                "Welcome!", "Sign up", "Sign up with email address"),
            Padding(
              padding: EdgeInsets.only(top: 40.h),
              child: Divider(
                height: 2.h,
                thickness: 5.w,
                color: brownColor,
                endIndent: 190.w,
                indent: 35.w,
              ),
            ),
            SizedBox(height: 40.h),
            Padding(
              padding: EdgeInsets.only(left: 30.w, right: 30.w),
              child: TextFieldInput(
                textEditingController: usernameController,
                hintText: "enter your username",
                labelText: "Username",
                icon: Icons.person,
              ),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.only(left: 30.w, right: 30.w),
              child: TextFieldInput(
                textEditingController: emailController,
                hintText: "enter your email",
                labelText: "Email",
                icon: Icons.email,
              ),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.only(left: 30.w, right: 30.w),
              child: TextFieldInput(
                textEditingController: passwordController,
                hintText: "enter your password",
                labelText: "Password",
                icon: Icons.lock,
              ),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.only(left: 30.w, right: 30.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      AuthController.instance.register(
                        usernameController.text.trim(),
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );
                    },
                    child: reusableBtn(
                      "register",
                      "Sign up",
                      whiteColor,
                      brownColor,
                    ),
                  ),
                  Text(
                    "Forgot Password",
                    style: GoogleFonts.averiaSansLibre(
                      fontSize: 16.sp,
                      color: Colors.blue[800],
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.blue[800],
                      decorationThickness: 2,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          reusableTxt(
            "Already have an account?",
            brownColor,
            16.sp,
            FontWeight.normal,
          ),
          SizedBox(
            width: 5.w,
          ),
          GestureDetector(
            onTap: () => Get.toNamed('/signin'),
            child: Text(
              "Sign in",
              style: GoogleFonts.averiaSansLibre(
                color: Colors.blue[700],
                fontSize: 16.sp,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
