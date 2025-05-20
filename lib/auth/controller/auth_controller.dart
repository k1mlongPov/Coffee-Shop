import 'package:coffeeshop/auth/pages/auth_screen.dart';
import 'package:coffeeshop/home/widgets/reusable_items.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  //AuthController.instance..
  static AuthController instance = Get.find();
  //email,password,name...
  late Rx<User?> _user;
  RxString username = ''.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  var isEmailVerified = false.obs;
  var isLoading = false.obs;
  var verificationId = ''.obs;
  var otpCode = ''.obs;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    // our user would be notified
    _user.bindStream(auth.userChanges());

    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      Get.offAll('/getstarted');
    } else {
      Get.offAndToNamed('/home');
    }
  }

  void register(String username, String email, String password) async {
    try {
      isLoading.value = true;
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await firestore.collection('users').doc(userCredential.user!.uid).set({
        'username': username,
        'email': email,
        'uid': userCredential.user!.uid,
      });
      await userCredential.user?.sendEmailVerification();
      Get.snackbar("Verification Email Sent", "Please check your inbox.");
      // Start checking if email is verified
      await checkEmailVerification();
    } catch (e) {
      Get.snackbar(
        "About user",
        "User message",
        snackPosition: SnackPosition.BOTTOM,
        titleText: reusableTxt(
            "Account creation failed", brownColor, 16.sp, FontWeight.normal),
        messageText: Text(
          e.toString(),
          style: const TextStyle(color: brownColor),
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkEmailVerification() async {
    User? user = auth.currentUser;
    await user?.reload(); // Refresh user state
    isEmailVerified.value = user?.emailVerified ?? false;

    if (isEmailVerified.value) {
      Get.offAll('/home');
    } else {
      // Keep checking every few seconds
      Future.delayed(const Duration(seconds: 3), () {
        checkEmailVerification();
      });
    }
  }

  Future<void> login(String email, password) async {
    try {
      isLoading.value = true;
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      DocumentSnapshot userDoc = await firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
      username.value = userDoc['username'];
    } catch (e) {
      Get.snackbar(
        "About Login",
        "Login message",
        snackPosition: SnackPosition.BOTTOM,
        titleText: reusableTxt(
            "Account Login failed", brownColor, 16.sp, FontWeight.normal),
        messageText: Text(
          e.toString(),
          style: const TextStyle(color: brownColor),
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      Get.snackbar(
        "Password Reset",
        "A password reset link has been sent to $email",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.indicatorColor,
        colorText: Colors.white,
      );
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      return userCredential;
    } catch (e) {
      Get.snackbar("Error", "Google Sign-In Failed: $e");
      return null;
    }
  }

  Future<void> signOutUser() async {
    try {
      await googleSignIn.signOut();

      await FirebaseAuth.instance.signOut(); // Firebase sign-out

      Get.offAll(() => const AuthScreen()); // Navigate to login page
    } catch (e) {
      Get.snackbar("Authentication Error", "Error during sign-out: $e");
    }
  }
}
