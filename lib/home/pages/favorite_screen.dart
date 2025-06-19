import 'package:coffeeshop/home/controller/favorite_controller.dart';
import 'package:coffeeshop/home/controller/search_controller.dart';
import 'package:coffeeshop/home/widgets/product_items.dart';
import 'package:coffeeshop/home/widgets/reusable_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});
  final FavoriteController favController = Get.put(FavoriteController());
  final SearchBarController searchController = Get.put(SearchBarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.offAllNamed('/home');
          },
          icon: Icon(
            Icons.coffee_outlined,
            size: 30.r,
            color: whiteColor,
          ),
        ),
        actions: [
          IconButton(
            icon: Obx(
              () => Icon(
                searchController.isExpanded.value ? null : Icons.search,
                size: 20,
                color: whiteColor,
              ),
            ),
            onPressed: searchController.toggleSearch, // Correctly toggle search
          ),
        ],
        backgroundColor: brownColor,
      ),
      body: Obx(
        () {
          return Padding(
            padding: EdgeInsets.all(25.r),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        size: 18.r,
                        color: brownColor,
                      ),
                      SizedBox(width: 10.w),
                      reusableTxt(
                          'My Favorite', brownColor, 18.sp, FontWeight.bold),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.only(bottom: 30.h),
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 25,
                      mainAxisSpacing: 25,
                      childAspectRatio: 1 / 1.6,
                      shrinkWrap: true,
                      primary: false,
                      children: List.generate(
                        favController.favorites.length,
                        (index) => productItems(
                          favController.favorites[index],
                          index,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/*
ListView.builder(
          itemCount: favController.favoriteProducts.length,
          
          itemBuilder: (_, index) {
            final product = favController.favoriteProducts[index];
            return productItems(product, index);
          },
        );
        */
