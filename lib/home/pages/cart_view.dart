import 'package:coffeeshop/home/controller/cart_controller.dart';
import 'package:coffeeshop/home/widgets/reusable_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CartView extends StatelessWidget {
  final CartController cartController = Get.find();

  CartView({super.key});

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
        title: reusableTxt("My Cart", whiteColor, 18.sp, FontWeight.bold),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => cartController.clearCart(),
            icon: Icon(
              Icons.delete,
              color: whiteColor,
              size: 18.r,
            ),
          ),
        ],
      ),
      body: Padding(
        padding:
            EdgeInsets.only(left: 25.w, right: 25.w, top: 20.h, bottom: 25.h),
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                ...cartController.cartItems.values.map(
                  (item) => Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10.h),
                        width: double.infinity,
                        height: 80.h,
                        decoration: const BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(blurRadius: 3, color: Colors.grey),
                          ],
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 100.w,
                              height: double.infinity,
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: Image.asset(
                                  item.productModel.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  reusableTxt(
                                    "${item.productModel.title} (${item.size})",
                                    brownColor,
                                    16.sp,
                                    FontWeight.bold,
                                  ),
                                  reusableTxt(
                                    "\$ ${item.price}",
                                    brownColor,
                                    16.sp,
                                    FontWeight.normal,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 10.h,
                        right: 10.w,
                        child: Container(
                          width: 20.w,
                          height: 20.w,
                          decoration: BoxDecoration(
                            color: brownColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: GestureDetector(
                            onTap: () => cartController.removeItem(
                              item.productModel,
                              item.size,
                            ),
                            child: Icon(
                              Icons.close,
                              size: 16.r,
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20.h,
                        right: 10.w,
                        child: Container(
                          width: 70.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: whiteColor,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 2,
                                  color: brownColor,
                                )
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () => cartController.removeFromCart(
                                  item.productModel,
                                  item.size,
                                ),
                                child: const Icon(
                                  Icons.remove,
                                  color: brownColor,
                                ),
                              ),
                              reusableTxt("${item.quantity}", brownColor, 16.sp,
                                  FontWeight.normal),
                              GestureDetector(
                                onTap: () => cartController.addToCart(
                                    item.productModel, item.size),
                                child: const Icon(
                                  Icons.add,
                                  color: brownColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    reusableTxt(
                      'Total Price: \$${cartController.totalPrice.toStringAsFixed(2)}',
                      brownColor,
                      16.sp,
                      FontWeight.bold,
                    ),
                    reusableTxt(
                      'Quantity: ${cartController.totalQuantity}',
                      brownColor,
                      16.sp,
                      FontWeight.bold,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
