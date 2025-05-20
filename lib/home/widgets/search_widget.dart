import 'package:coffeeshop/home/controller/search_controller.dart';
import 'package:coffeeshop/home/widgets/reusable_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchWidget extends StatelessWidget {
  SearchWidget({super.key});
  final SearchBarController searchController = Get.put(SearchBarController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: searchController.isExpanded.value
            ? MediaQuery.of(context).size.width * 1
            : 0,
        height: searchController.isExpanded.value ? 80 : 0,
        decoration: const BoxDecoration(
          color: whiteColor,
        ),
        child: TextField(
          onChanged: (value) => searchController.searchQuery.value = value,
          textAlignVertical: TextAlignVertical.center,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          style: GoogleFonts.averiaLibre(color: brownColor, fontSize: 16.sp),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10.h),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2.w,
                color: brownColor,
              ),
              borderRadius: BorderRadius.circular(15.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2.w,
                color: brownColor,
              ),
              borderRadius: BorderRadius.circular(5.r),
            ),
            suffixIcon: searchController.isExpanded.value
                ? IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 20.w,
                      color: brownColor,
                    ),
                    onPressed: searchController.toggleSearch,
                  )
                : null,
            hintText: 'What do you want to drink?',
            hintStyle: GoogleFonts.averiaLibre(
              color: brownColor,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
