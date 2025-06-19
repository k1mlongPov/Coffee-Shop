import 'package:coffeeshop/home/controller/product_controller.dart';
import 'package:coffeeshop/home/model/product_model.dart';
import 'package:get/get.dart';

class SearchBarController extends GetxController {
  var isExpanded = false.obs;
  //var productList = <ProductModel>[].obs;
  var filteredList = <ProductModel>[].obs;
  final ProductController productController = Get.put(ProductController());

  var searchQuery = ''.obs; // Observable

  @override
  void onInit() {
    super.onInit();

    filteredList.value = productController.myProducts;

    // Automatically filter when searchQuery changes
    ever(searchQuery, (_) => filterProducts());
  }

  void filterProducts() {
    if (searchQuery.value.isEmpty) {
      filteredList.value = productController.myProducts;
    } else {
      filteredList.value = productController.myProducts
          .where((product) => product.title
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

  void toggleSearch() {
    isExpanded.value = !isExpanded.value; // Toggle the state
  }

  void noAction() {}
}
