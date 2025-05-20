import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget imageWidget() {
  return Container(
    width: double.infinity,
    height: 350,
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("asset/images/auth_coffeeshop_img.png"),
      ),
    ),
    child: Stack(
      children: [
        Positioned(
          top: 10.h,
          left: 20.w,
          child: Image(
            width: 55.w,
            height: 55.h,
            image: const AssetImage("asset/icons/tea-leaf.png"),
          ),
        ),
        Positioned(
          bottom: 10.h,
          right: 20.w,
          child: Image(
            width: 55.w,
            height: 55.h,
            image: const AssetImage("asset/icons/coffee-beans3.png"),
          ),
        ),
      ],
    ),
  );
}
