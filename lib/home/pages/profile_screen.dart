import 'package:coffeeshop/auth/controllers/auth_controller.dart';
import 'package:coffeeshop/home/controller/link_controller.dart';
import 'package:coffeeshop/home/controller/pfp_controller.dart';
import 'package:coffeeshop/home/controller/product_controller.dart';
import 'package:coffeeshop/home/widgets/reusable_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final AuthController authController = Get.put(AuthController());
  final ProductController productController = Get.put(ProductController());
  final ProfileController profileController = Get.put(ProfileController());
  final LinkController linkController = Get.put(LinkController());
  final httpLink = "https://www.youtube.com/";
  final pfPicture = AuthController.to.firestoreUser.value!.photo.toString();

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
        backgroundColor: brownColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(25.r),
        child: Obx(
          () => Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 120.w,
                          height: 120.w,
                          decoration: BoxDecoration(
                            color: brownColor,
                            borderRadius: BorderRadius.circular(60.r),
                            border: Border.all(width: 2, color: brownColor),
                          ),
                          child: CircleAvatar(
                            backgroundImage: authController
                                    .firestoreUser.value!.photo!.isNotEmpty
                                ? NetworkImage(pfPicture)
                                : const AssetImage('asset/images/user.png'),
                          ),
                        ),
                        Positioned(
                          child: profileController.isUploading.value
                              ? const CircularProgressIndicator()
                              : GestureDetector(
                                  onTap: () async {
                                    await authController.updateUserPhotoUrl();
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                  ),
                                ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: reusableTxt(
                      '@${authController.firestoreUser.value!.username}',
                      brownColor,
                      18.sp,
                      FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Divider(
                    height: 1.h,
                    thickness: 3.w,
                    color: brownColor,
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      reusableTxt(
                        'Username: @',
                        brownColor,
                        16.sp,
                        FontWeight.bold,
                      ),
                      reusableTxt(
                        authController.firestoreUser.value!.username.toString(),
                        brownColor,
                        16.sp,
                        FontWeight.normal,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      reusableTxt(
                        'Email: ',
                        brownColor,
                        16.sp,
                        FontWeight.bold,
                      ),
                      reusableTxt(
                        authController.firestoreUser.value!.email.toString(),
                        brownColor,
                        16.sp,
                        FontWeight.normal,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: brownColor,
                            size: 18.r,
                          ),
                          SizedBox(width: 5.w),
                          reusableTxt(
                            'Favorite',
                            brownColor,
                            16.sp,
                            FontWeight.bold,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed('/favorite'),
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: brownColor,
                          size: 20.r,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      reusableTxt(
                        'About Me',
                        brownColor,
                        16.sp,
                        FontWeight.bold,
                      ),
                      GestureDetector(
                        onTap: () =>
                            linkController.launchUrlSiteBrowser(url: httpLink),
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: brownColor,
                          size: 20.r,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => authController.signOutUser(),
                            child: Icon(
                              Icons.logout_outlined,
                              color: brownColor,
                              size: 20.r,
                            ),
                          ),
                          SizedBox(width: 5.w),
                          reusableTxt(
                            'Sign out',
                            brownColor,
                            16.sp,
                            FontWeight.bold,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              authController.isLoading.value
                  ? Container(
                      margin: EdgeInsets.all(8.r),
                      child: const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: whiteColor,
                          color: brownColor,
                          strokeWidth: 4,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
