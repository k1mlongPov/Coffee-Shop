import 'package:coffeeshop/home/model/category_model.dart';
import 'package:coffeeshop/home/pages/category_screen.dart';
import 'package:coffeeshop/home/widgets/reusable_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CatagoryWidget extends StatelessWidget {
  const CatagoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: whiteColor,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 0; i < listCategory.length; i++)
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () => Get.to(
                    () => CategoryScreen(categoryModel: listCategory[i]),
                    transition: Transition.fadeIn,
                    duration: const Duration(milliseconds: 500),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 60.w,
                        height: 60.w,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(30.r),
                          border: Border.all(width: 4.w, color: brownColor),
                        ),
                        child: Image.asset(
                          listCategory[i].imageIcon,
                          cacheWidth: 40,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      reusableTxt(
                        listCategory[i].name,
                        brownColor,
                        14.sp,
                        FontWeight.bold,
                      )
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
