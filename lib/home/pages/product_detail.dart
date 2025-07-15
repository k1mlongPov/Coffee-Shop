import 'package:coffeeshop/home/controller/cart_controller.dart';
import 'package:coffeeshop/home/model/product_model.dart';
import 'package:coffeeshop/home/widgets/reusable_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:badges/badges.dart' as badges;

class ProductDetail extends StatelessWidget {
  final ProductModel productModel;
  final CartController cartController = Get.find();

  ProductDetail({super.key, required this.productModel});

  final RxString? selectedSize = RxString('');

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Obx(
              () => badges.Badge(
                badgeContent: Text(
                  '${cartController.cartItems.length}',
                  style: const TextStyle(
                    color: whiteColor,
                  ),
                ),
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: Colors.brown,
                  padding: EdgeInsets.all(4),
                  elevation: 0,
                ),
                child: GestureDetector(
                  onTap: () => Get.toNamed('/cart'),
                  child: Icon(
                    Icons.shopping_cart,
                    color: whiteColor,
                    size: 24.r,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.only(left: 25.w, right: 25.w),
            child: Center(
              child: Container(
                width: 300.w,
                height: 180.h,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      spreadRadius: 2,
                      blurStyle: BlurStyle.normal,
                      color: Colors.grey,
                    ),
                  ],
                  color: brownColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  child: Image.asset(
                    productModel.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.only(left: 25.w, right: 25.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                reusableTxt(
                    productModel.title, brownColor, 16.sp, FontWeight.bold),
                Obx(
                  () => reusableTxt(
                    productModel.selectedPrice.value > 0
                        ? "Price: \$${productModel.selectedPrice.value.toStringAsFixed(2)}"
                        : "Please select a size",
                    brownColor,
                    16.sp,
                    FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.only(left: 25.w, right: 25.w),
            child: RatingBar.builder(
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
                // ignore: avoid_print
                print(rating);
              },
            ),
          ),
          SizedBox(height: 20.h),
          Obx(
            () => Padding(
              padding: EdgeInsets.only(left: 25.w, right: 25.w),
              child: Wrap(
                spacing: 10,
                children: productModel.sizes.map((size) {
                  return ChoiceChip(
                    checkmarkColor: whiteColor,
                    backgroundColor: whiteColor,
                    selectedColor: brownColor,
                    label: reusableTxt(
                      size,
                      selectedSize.toString() == size ? whiteColor : brownColor,
                      14.sp,
                      FontWeight.normal,
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: brownColor, width: 1.r),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    selected: selectedSize!.value == size,
                    onSelected: (_) {
                      selectedSize!.value = size;
                      final index = productModel.sizes.indexOf(size);
                      productModel.selectedPrice.value =
                          index != -1 ? productModel.prices[index] : 0.0;
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Padding(
              padding: EdgeInsets.only(left: 25.w, right: 25.w),
              child: reusableTxt(
                'Description',
                brownColor,
                16.sp,
                FontWeight.bold,
              )),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.only(left: 25.w, right: 25.w),
            child: ReadMoreText(
              productModel.description,
              textAlign: TextAlign.justify,
              style: GoogleFonts.athiti(
                color: brownColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              trimLines: 3,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Show more',
              trimExpandedText: 'Show less',
              lessStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
              moreStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: whiteColor,
        height: 70.h,
        padding: EdgeInsets.only(left: 25.w, right: 25.w, bottom: 25.w),
        child: GestureDetector(
          onTap: () {
            final size = selectedSize!.value;
            if (size.isEmpty) {
              final snackBar = SnackBar(
                content: reusableTxt(
                  'Please select a size!',
                  whiteColor,
                  16.sp,
                  FontWeight.normal,
                ),
                duration: const Duration(milliseconds: 800),
                backgroundColor: Colors.grey.withOpacity(0.5),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              return;
            }
            cartController.addToCart(productModel, size);
            final snackBar = SnackBar(
              content: reusableTxt(
                'Added ${productModel.title} ($size) to cart',
                brownColor,
                14.sp,
                FontWeight.normal,
              ),
              margin: EdgeInsets.only(left: 25.w, right: 25.w, bottom: 10.h),
              duration: const Duration(milliseconds: 1000),
              backgroundColor: whiteColor,
              behavior: SnackBarBehavior.floating,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: brownColor,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: reusableTxt(
                "Add to Cart",
                whiteColor,
                16.sp,
                FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


/*
  Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: brownColor,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: GestureDetector(
              onTap: () {
                final size = selectedSize!.value;
                if (size.isEmpty) {
                  Get.snackbar("Size Required", "Please select a size");
                  return;
                }
                cartController.addToCart(productModel, size);
                Get.snackbar(
                    "Added", "${productModel.title} ($size) added to cart");
              },
              child: const Text("Add to Cart"),
            ),
          ),
        ),
*/
