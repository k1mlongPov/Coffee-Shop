import 'package:coffeeshop/home/model/product_model.dart';
import 'package:get/get.dart';

class RefreshAppController extends GetxController {
  var items = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadItems();
  }

  void loadItems() {
    ProductModel.products;
  }

  Future<void> refreshItems() async {
    await Future.delayed(const Duration(seconds: 2));
    items.value = List.generate(20, (index) => 'Refreshed Item ${index + 1}');
  }
}
