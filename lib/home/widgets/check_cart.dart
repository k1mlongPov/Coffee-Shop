import 'package:coffeeshop/home/controller/cart_controller.dart';
import 'package:coffeeshop/home/pages/cart_view.dart';
import 'package:coffeeshop/home/widgets/empty_cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckCart extends StatelessWidget {
  CheckCart({super.key});
  final CartController cartController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => cartController.cartItems.isEmpty ? const EmptyCart() : CartView(),
    );
  }
}
