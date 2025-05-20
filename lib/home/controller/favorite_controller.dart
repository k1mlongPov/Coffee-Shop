import 'package:coffeeshop/home/model/product_model.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  var favoriteProducts = <ProductModel>[].obs;

  void toggleFavorite(ProductModel product) {
    if (favoriteProducts.contains(product)) {
      favoriteProducts.remove(product);
    } else {
      favoriteProducts.add(product);
    }
  }

  bool isFavorite(ProductModel product) => favoriteProducts.contains(product);
}
