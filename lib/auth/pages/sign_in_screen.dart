import 'package:coffeeshop/auth/controller/auth_controller.dart';
import 'package:coffeeshop/auth/widgets/sign_in_widget.dart';
import 'package:coffeeshop/auth/widgets/textfield_input.dart';
import 'package:coffeeshop/home/widgets/reusable_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 670));
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            clipPathWidgetForLogin(
                "Welcome Back!", "Sign in", "Sign in with email address"),
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
                textEditingController: emailController,
                hintText: "enter your email address",
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
                    onTap: () async {
                      await AuthController.instance.login(
                          emailController.text.trim(),
                          passwordController.text.trim());
                    },
                    child: reusableBtn(
                      "sign in",
                      "Sign in",
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
            "Do not have an account?",
            brownColor,
            16.sp,
            FontWeight.normal,
          ),
          SizedBox(
            width: 5.w,
          ),
          GestureDetector(
            onTap: () => Get.toNamed('/register'),
            child: Text(
              "Register",
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
