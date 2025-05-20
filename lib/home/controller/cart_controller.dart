import 'package:coffeeshop/home/model/cart_model.dart';
import 'package:coffeeshop/home/model/product_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <String, CartModel>{}.obs;

  String _key(ProductModel productModel, String size) =>
      "${productModel.id}-$size";

  void addToCart(ProductModel productModel, String size) {
    final key = _key(productModel, size);
    final price = productModel.getPriceBySize(size);

    if (cartItems.containsKey(key)) {
      cartItems[key]!.quantity++;
    } else {
      cartItems[key] = CartModel(
        productModel: productModel,
        size: size,
        price: price,
      );
    }
    cartItems.refresh();
  }

  void removeFromCart(ProductModel productModel, String size) {
    final key = _key(productModel, size);
    if (cartItems.containsKey(key)) {
      if (cartItems[key]!.quantity > 1) {
        cartItems[key]!.quantity--;
      }
    }
    cartItems.refresh();
  }

  void removeItem(ProductModel productModel, String size) {
    final key = _key(productModel, size);
    cartItems.remove(key);
  }

  void clearCart() => cartItems.clear();

  double get totalPrice =>
      cartItems.values.fold(0, (sum, item) => sum + item.totalPrice);

  int get totalQuantity =>
      cartItems.values.fold(0, (sum, item) => sum + item.quantity);
}
