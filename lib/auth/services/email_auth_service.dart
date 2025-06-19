import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeeshop/auth/model/user_model.dart';
import 'package:coffeeshop/home/controller/favorite_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class EmailAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FavoriteController favoriteController = Get.put(FavoriteController());
  var firestoreUser = Rxn<UserModel>();

  Future<void> signInWithEmail(String email, String password) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    final user = userCredential.user;

    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'username': '',
        'photoUrl': '',
        'phone': '',
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    }
  }

  Future<void> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      // 1. Create Firebase Auth user
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = cred.user!.uid;

      // 2. Create UserModel with empty photoUrl or a default
      final newUser = UserModel(
        uid: uid,
        username: username,
        email: email,
        photo: '', // or a default URL if you have one
      );

      // 3. Save to Firestore
      await _firestore.collection('users').doc(uid).set(newUser.toJson());

      // 4. Update local Rx
      firestoreUser.value = newUser;
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  /// Sign In with email & password
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await favoriteController.fetchFavorites();
      // authStateChanges listener will take care of navigation & loading Firestore user
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}
