import 'package:coffeeshop/home/controller/product_controller.dart';
import 'package:coffeeshop/home/model/product_model.dart';
import 'package:get/get.dart';

class RefreshAppController extends GetxController {
  var items = <ProductModel>[].obs;
  final ProductController productController = Get.put(ProductController());

  @override
  void onInit() {
    super.onInit();
    loadItems();
  }

  void loadItems() {
    productController.myProducts;
  }

  Future<void> refreshItems() async {
    await Future.delayed(const Duration(seconds: 2));
    items.length;
  }
}
