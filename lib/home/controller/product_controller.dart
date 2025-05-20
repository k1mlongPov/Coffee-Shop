import 'package:coffeeshop/home/model/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  RxList<ProductModel> list = <ProductModel>[].obs;
  var selectedSize = ''.obs;
  var selectedPrice = 0.0.obs;

  void addCart(ProductModel productModel) {
    list.add(productModel);
    update();
  }

  void deleteCart(ProductModel productModel) {
    list.remove(productModel);
    update();
  }

  void increase(ProductModel productModel) {
    productModel.counter++;
  }

  void decrease(ProductModel productModel) {
    productModel.counter--;
  }
}
