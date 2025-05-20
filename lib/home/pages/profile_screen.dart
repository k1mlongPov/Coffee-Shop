import 'package:coffeeshop/auth/controller/auth_controller.dart';
import 'package:coffeeshop/home/widgets/reusable_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(75.r),
            child: authController.auth.currentUser!.photoURL != null
                ? Image.network('${authController.auth.currentUser!.photoURL}')
                : const Icon(Icons.account_circle_rounded),
          ),
          reusableTxt('@${authController.auth.currentUser!.displayName}',
              brownColor, 18.sp, FontWeight.bold),
        ],
      ),
    );
  }
}
