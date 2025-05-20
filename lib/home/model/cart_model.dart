import 'package:coffeeshop/home/model/product_model.dart';

class CartModel {
  final ProductModel productModel;
  final String size;
  final double price;
  int quantity;

  CartModel({
    required this.productModel,
    required this.size,
    required this.price,
    this.quantity = 1,
  });

  double get totalPrice => price * quantity;
}
