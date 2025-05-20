import 'package:coffeeshop/auth/widgets/clippath_widget.dart';
import 'package:coffeeshop/home/widgets/reusable_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Widget clipPathWidgetForLogin(
    String welcomeText, String authNameType, String subText) {
  return Stack(
    children: [
      CustomPaint(
        size: Size(double.infinity, 210.h),
        painter: RPSCustomPainter(),
      ),
      Positioned(
        top: 50.h,
        left: 25.w,
        child: GestureDetector(
            onTap: () => Get.offAndToNamed('/auth'),
            child: Container(
              width: 30.w,
              height: 30.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.w),
                color: whiteColor,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: brownColor,
              ),
            )),
      ),
      Positioned(
        top: 40.h,
        right: 35.w,
        child: Text(
          welcomeText,
          style: GoogleFonts.julee(
            color: whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 35.sp,
          ),
        ),
      ),
      Positioned(
        bottom: 50.h,
        right: 60.w,
        child: const Image(
          image: AssetImage("asset/icons/coffee-beans3.png"),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 35.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            reusableTxt(authNameType, brownColor, 28.sp, FontWeight.bold),
            SizedBox(height: 30.h),
            reusableTxt(subText, brownColor, 16.sp, FontWeight.normal),
          ],
        ),
      ),
    ],
  );
}
