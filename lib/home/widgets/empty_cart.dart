import 'package:coffeeshop/home/pages/home_screen.dart';
import 'package:coffeeshop/home/widgets/reusable_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: brownColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: whiteColor,
            size: 18.r,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 80.h),
            Container(
              decoration: BoxDecoration(
                color: brownColor,
                borderRadius: BorderRadius.circular(175),
              ),
              width: 250.r,
              height: 250.r,
              child:
                  const Image(image: AssetImage('asset/images/empty_cart.png')),
            ),
            const SizedBox(height: 30),
            reusableTxt(
                "Your cart is empty", brownColor, 20.sp, FontWeight.bold),
            const SizedBox(height: 10),
            reusableTxt(
              'You have not add any items to cart yet!',
              brownColor,
              16.sp,
              FontWeight.normal,
            ),
            SizedBox(height: 80.h),
            Container(
              width: 250.w,
              height: 50.h,
              decoration: BoxDecoration(
                color: brownColor,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: GestureDetector(
                  onTap: () => Get.off(
                    HomeScreen(),
                    transition: Transition.fade,
                    duration: const Duration(milliseconds: 800),
                  ),
                  child: reusableTxt(
                    "Shop now",
                    whiteColor,
                    18.sp,
                    FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
