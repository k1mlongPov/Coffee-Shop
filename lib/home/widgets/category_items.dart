import 'package:coffeeshop/home/model/product_model.dart';
import 'package:coffeeshop/home/pages/product_detail.dart';
import 'package:coffeeshop/home/widgets/reusable_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget itemByCategory(
  BuildContext context,
  ProductModel productModel,
  int index,
) {
  return GestureDetector(
    onTap: () {
      Get.to(
        () => ProductDetail(
          productModel: productModel,
        ),
        transition: Transition.fade,
      );
    },
    child: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(
              20,
            ),
            boxShadow: const [
              BoxShadow(
                blurRadius: 4,
                offset: Offset(1, 3),
                color: Colors.grey,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 120,
                color: whiteColor,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.asset(
                    productModel.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 6.h),
              reusableTxt(
                productModel.title,
                brownColor,
                16.sp,
                FontWeight.normal,
              ),
              SizedBox(height: 6.h),
              Row(
                children: [
                  reusableTxt('\$', brownColor, 16.sp, FontWeight.normal),
                  reusableTxt('${productModel.prices[0]}', brownColor, 16.sp,
                      FontWeight.bold)
                ],
              ),
              SizedBox(height: 6.h),
              RatingBar.builder(
                ignoreGestures: true,
                initialRating: productModel.rate,
                minRating: 1,
                itemSize: 18,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              SizedBox(height: 6.h),
              reusableTxt(
                'Sold ${productModel.soldCounter}+',
                brownColor.withOpacity(0.5),
                14.sp,
                FontWeight.w300,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () => {},
            child: Container(
              width: 30.w,
              height: 30.w,
              decoration: const BoxDecoration(
                color: brownColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
              ),
              child: const Icon(
                Icons.add,
                color: whiteColor,
                size: 20,
              ),
            ),
          ),
        )
      ],
    ),
  );
}
