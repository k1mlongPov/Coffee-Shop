import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeeshop/home/model/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var favorites = <ProductModel>[].obs;

  String get userId => _auth.currentUser!.uid;

  /// Add to favorites
  Future<void> addFavorite(ProductModel item) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .doc(item.id.toString())
          .set(item.toJson());

      favorites.add(item);
    } catch (e) {
      Get.snackbar("Error", "Failed to add favorite: $e");
    }
  }

  /// Remove from favorites
  Future<void> removeFavorite(int id) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .doc(id.toString())
          .delete();

      favorites.removeWhere((item) => item.id == id);
    } catch (e) {
      Get.snackbar("Error", "Failed to remove favorite: $e");
    }
  }

  /// Load favorites from Firestore
  Future<void> fetchFavorites() async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .get();

      favorites.value = snapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      e.printError();
    }
  }
}
