import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeeshop/home/model/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  RxList<ProductModel> list = <ProductModel>[].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var myProducts = <ProductModel>[].obs;
  var selectedSize = ''.obs;
  var selectedPrice = 0.0.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

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

  Future<void> uploadProduct(ProductModel product) async {
    try {
      await _firestore
          .collection('products')
          .doc(product.id.toString())
          .set(product.toJson());
      Get.snackbar('Success', '${product.title} uploaded to Firestore');
    } catch (e) {
      e.printError();
      Get.snackbar('Error', 'Failed to upload ${product.title}');
    }
  }

  Future<void> uploadAllProducts(List<ProductModel> products) async {
    for (final product in products) {
      await uploadProduct(product);
    }
  }

  void fetchProducts() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('products').get();

      final productList = snapshot.docs.map((doc) {
        return ProductModel.fromJson(doc.data());
      }).toList();

      myProducts.value = productList;
    } catch (e) {
      e.printError();
      Get.snackbar("Error", e.toString());
    }
  }
}
