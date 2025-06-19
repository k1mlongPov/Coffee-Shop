import 'package:coffeeshop/home/controller/product_controller.dart';
import 'package:coffeeshop/home/model/category_model.dart';
import 'package:coffeeshop/home/widgets/category_items.dart';
import 'package:coffeeshop/home/widgets/reusable_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

// ignore: must_be_immutable
class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key, required this.categoryModel});
  final ProductController productController = Get.put(ProductController());
  final CategoryModel categoryModel;
  late List listByCategory = productController.myProducts
      .where((element) => element.categoryId == categoryModel.id)
      .toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: brownColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20.w,
            color: whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: StickyHeader(
          header: Column(
            children: [
              Container(
                color: whiteColor,
                child: Padding(
                  padding: EdgeInsets.all(20.r),
                  child: Row(
                    children: [
                      Image.asset(
                        categoryModel.imageIcon,
                        width: 40.r,
                      ),
                      SizedBox(width: 20.w),
                      Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: reusableTxt(categoryModel.name, brownColor,
                            18.sp, FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 1.h,
                thickness: 3.w,
                color: brownColor,
                endIndent: 210,
                indent: 25,
              ),
            ],
          ),
          content: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 25,
                  mainAxisSpacing: 25,
                  childAspectRatio: 1 / 1.6,
                  shrinkWrap: true,
                  primary: false,
                  children: List.generate(
                    listByCategory.length,
                    (index) => itemByCategory(
                      context,
                      listByCategory[index],
                      index,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
