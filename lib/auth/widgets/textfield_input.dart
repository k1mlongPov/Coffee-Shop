import 'package:coffeeshop/home/widgets/reusable_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass = false;
  final String hintText;
  final String labelText;
  final IconData? icon;
  const TextFieldInput({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.labelText,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //Type TextField
      width: double.infinity,
      height: 50.h,
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: brownColor, width: 2),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: brownColor),
          ),
          prefixIcon: Icon(
            icon,
            color: brownColor,
          ),
          labelText: labelText,
          labelStyle: GoogleFonts.averiaLibre(
            color: brownColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.normal,
          ),
          hintText: hintText,
          // pass the hint text parameter here
          hintStyle: const TextStyle(color: brownColor),
        ),
        obscureText: isPass,
        style: GoogleFonts.averiaLibre(
          color: brownColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
