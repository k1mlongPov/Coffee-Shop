import 'package:coffeeshop/home/controller/refresh_app_controller.dart';
import 'package:coffeeshop/home/controller/search_controller.dart';
import 'package:coffeeshop/home/widgets/catagory_widget.dart';
import 'package:coffeeshop/home/widgets/product_items.dart';
import 'package:coffeeshop/home/widgets/reusable_items.dart';
import 'package:coffeeshop/home/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final SearchBarController searchController = Get.put(SearchBarController());
  final RefreshAppController refreshAppController =
      Get.put(RefreshAppController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        body: Obx(() => RefreshIndicator(
              backgroundColor: brownColor,
              color: whiteColor,
              onRefresh: () => refreshAppController.refreshItems(),
              child: Padding(
                padding: EdgeInsets.all(25.r),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.category_rounded,
                            color: brownColor,
                          ),
                          SizedBox(width: 10.w),
                          reusableTxt(
                            "Category",
                            brownColor,
                            18.sp,
                            FontWeight.bold,
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      const CatagoryWidget(),
                      SizedBox(height: 16.h),
                      Divider(
                        height: 1.h,
                        thickness: 3.w,
                        color: brownColor,
                      ),
                      SizedBox(height: 32.h),
                      SearchWidget(),
                      reusableTxt(
                          'All Drinks', brownColor, 18.sp, FontWeight.bold),
                      SizedBox(height: 20.h),
                      GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 25,
                        mainAxisSpacing: 25,
                        childAspectRatio: 1 / 1.6,
                        shrinkWrap: true,
                        primary: false,
                        children: List.generate(
                          searchController.filteredList.length,
                          (index) => productItems(
                            searchController.filteredList[index],
                            index,
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              ),
            )));
  }
}
