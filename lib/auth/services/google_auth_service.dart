import 'package:coffeeshop/auth/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GoogleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var firestoreUser = Rxn<UserModel>();

  Future<void> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return; // User cancelled

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user!;
      final uid = user.uid;

      final userDoc = await _firestore.collection('users').doc(uid).get();

      if (!userDoc.exists) {
        // Only create Firestore doc if not exists
        final newUser = UserModel(
          uid: uid,
          username: user.displayName ?? 'No Name',
          email: user.email ?? '',
          phoneNumber: user.phoneNumber ?? '',
          photo: user.photoURL ?? '', // Use Google profile image!
        );

        await _firestore.collection('users').doc(uid).set(newUser.toJson());
        firestoreUser.value = newUser;
      } else {
        // Existing user, load from Firestore
        firestoreUser.value = UserModel.fromDoc(userDoc);

        Get.offAllNamed('/home');
      }
    } catch (e) {
      Get.snackbar('Google Sign-In Failed', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
