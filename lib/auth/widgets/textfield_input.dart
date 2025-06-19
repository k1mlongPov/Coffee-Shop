import 'package:coffeeshop/home/widgets/reusable_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final String labelText;
  final IconData? prefixIcon;
  final IconButton? suffixIcon;
  final bool isPassword;
  final RxBool? obscureText;

  const TextFieldInput({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.labelText,
    this.isPassword = true,
    this.obscureText,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: isPassword && obscureText != null
          ? Obx(() => buildTextField(obscureText!.value))
          : buildTextField(false),
    );
  }

  Widget buildTextField(bool isObscured) {
    return TextField(
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      controller: textEditingController,
      obscureText: isPassword ? isObscured : false,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: brownColor, width: 2.w),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: brownColor),
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: brownColor,
        ),
        suffixIcon: suffixIcon,
        labelText: labelText,
        labelStyle: GoogleFonts.averiaLibre(
          color: brownColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: brownColor),
      ),
      style: GoogleFonts.averiaLibre(
        color: brownColor,
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
