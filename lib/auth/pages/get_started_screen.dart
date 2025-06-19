import 'package:coffeeshop/home/widgets/reusable_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 60.h),
            Container(
              width: double.infinity,
              height: 330.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("asset/images/getstarted_coffee_img.png"),
                  fit: BoxFit.contain,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 10.h,
                    left: 20.w,
                    child: Image.asset(
                      "asset/icons/coffee-beans2.png",
                      width: 40.w,
                      height: 40.h,
                    ),
                  ),
                  Positioned(
                    top: 40.h,
                    right: 20.w,
                    child: Image.asset(
                      "asset/icons/tea-leaf.png",
                      width: 50.w,
                      height: 50.h,
                    ),
                  ),
                  Positioned(
                    bottom: 10.h,
                    right: 20.w,
                    child: Image.asset(
                      "asset/icons/coffee-beans3.png",
                      width: 50.w,
                      height: 50.h,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
                width: 200.w,
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Welcome to",
                        style: GoogleFonts.julee(
                          textStyle: TextStyle(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 114, 74, 40),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Elite Cofé",
                        style: GoogleFonts.julee(
                          textStyle: TextStyle(
                            fontSize: 46.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 114, 74, 40),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            GestureDetector(
              onTap: () => Get.offAllNamed('/auth'),
              child: Container(
                margin: EdgeInsets.only(top: 30.h),
                width: 250.w,
                height: 50.h,
                decoration: BoxDecoration(
                  color: brownColor,
                  borderRadius: BorderRadius.circular(25.r),
                ),
                child: Center(
                  child: Text(
                    "Get Started",
                    style: GoogleFonts.averiaLibre(
                      textStyle: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
