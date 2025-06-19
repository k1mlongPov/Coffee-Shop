import 'package:coffeeshop/auth/controllers/auth_controller.dart';
import 'package:coffeeshop/auth/widgets/auth_choices_widget.dart';
import 'package:coffeeshop/home/widgets/reusable_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(370, 790));
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                SizedBox(height: 70.h),
                imageWidget(),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => Get.toNamed("/signin"),
                        child: reusableBtn(
                            "sign in", "Sign in", whiteColor, brownColor),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed("/register"),
                        child: reusableBtn(
                            "register", "Sign up", brownColor, whiteColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                //
                GestureDetector(
                  child: buildThirdPartyLogin(
                    "asset/icons/phone_icon.png",
                    "Login with Phone number",
                    () => {
                      Get.toNamed('/phone'),
                    },
                  ),
                ),
                SizedBox(height: 20.h),
                GestureDetector(
                  child: buildThirdPartyLogin(
                    "asset/icons/google_icon.png",
                    "Sign in with google",
                    () => {
                      authController.signInWithGoogle(),
                    },
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
            Obx(
              () => authController.isLoading.value
                  ? Container(
                      margin: EdgeInsets.all(8.r),
                      child: const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: brownColor,
                          color: whiteColor,
                          strokeWidth: 4,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
