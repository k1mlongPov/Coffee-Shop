import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

const brownColor = Color(0xFFA06F48);
const whiteColor = Color(0xFFF3EEEA);

Widget reusableTxt(
    String text, Color color, double fontSize, FontWeight fontWeight) {
  return Text(
    text,
    style: GoogleFonts.averiaLibre(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
  );
}

Widget reusableBtn(
  String name,
  String btnName,
  Color fontColor,
  Color bgColor,
) {
  return Container(
    width: 130.w,
    height: 50.h,
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(75.r),
      border: Border.all(color: brownColor, width: 3.w),
    ),
    child: Center(
      child: reusableTxt(
        btnName,
        fontColor,
        18.sp,
        FontWeight.bold,
      ),
    ),
  );
}

Widget buildThirdPartyLogin(String iconPath, String text, Function()? onTap) {
  return Padding(
    padding: EdgeInsets.only(left: 40.w, right: 40.w),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(
            color: brownColor,
            width: 3.w,
          ),
          borderRadius: BorderRadius.circular(35.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              width: 50.w,
              height: 50.h,
              image: AssetImage(iconPath),
            ),
            reusableTxt(text, brownColor, 16.sp, FontWeight.normal)
          ],
        ),
      ),
    ),
  );
}
