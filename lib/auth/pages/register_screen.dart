import 'package:coffeeshop/auth/controllers/auth_controller.dart';
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
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _handleSignUp() {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        password != confirmPassword) {
      Get.snackbar('Invalid Input', 'All fields are required',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    AuthController.to.signUp(
      username: username,
      email: email,
      password: password,
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 670));
    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(
          () => Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  clipPathWidgetForRegister(
                    "Welcome!",
                    "Sign up",
                    "Sign up with email address",
                  ),
                  SizedBox(height: 15.h),
                  Divider(
                    height: 2.h,
                    thickness: 5.w,
                    color: brownColor,
                    endIndent: 190.w,
                    indent: 35.w,
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.only(left: 30.w, right: 30.w),
                    child: TextFieldInput(
                      textEditingController: _usernameController,
                      hintText: "enter your username",
                      labelText: "Username",
                      prefixIcon: Icons.person,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.only(left: 30.w, right: 30.w),
                    child: TextFieldInput(
                      textEditingController: _emailController,
                      hintText: "enter your email",
                      labelText: "Email",
                      prefixIcon: Icons.email,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.only(left: 30.w, right: 30.w),
                    child: TextFieldInput(
                      textEditingController: _passwordController,
                      hintText: "enter your password",
                      labelText: "Password",
                      prefixIcon: Icons.lock_rounded,
                      obscureText: authController.isPasswordHidden,
                      suffixIcon: IconButton(
                        onPressed: () =>
                            authController.togglePasswordVisibility(),
                        icon: Icon(
                          authController.isPasswordHidden.value
                              ? Icons.visibility_off
                              : Icons.remove_red_eye,
                          color: brownColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.only(left: 30.w, right: 30.w),
                    child: TextFieldInput(
                      textEditingController: _confirmPasswordController,
                      hintText: "enter your confirm password",
                      labelText: "Confirm Password",
                      prefixIcon: Icons.lock_reset_sharp,
                      obscureText: authController.isPasswordHidden,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.only(left: 30.w, right: 30.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _handleSignUp();
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
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
              authController.isLoading.value
                  ? Container(
                      margin: EdgeInsets.all(8.r),
                      child: const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: whiteColor,
                          color: brownColor,
                          strokeWidth: 4,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 50.h),
        child: Row(
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
      ),
    );
  }
}
