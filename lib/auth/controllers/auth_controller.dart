import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeeshop/auth/model/user_model.dart';
import 'package:coffeeshop/auth/services/email_auth_service.dart';
import 'package:coffeeshop/auth/services/google_auth_service.dart';
import 'package:coffeeshop/auth/services/phone_auth_service.dart';
import 'package:coffeeshop/auth/services/pick_image_service.dart';
import 'package:coffeeshop/home/controller/favorite_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FavoriteController favoriteController = Get.put(FavoriteController());

  final _emailService = EmailAuthService();
  final _googleService = GoogleAuthService();
  final _phoneService = PhoneAuthService();
  final _imageService = PickImageService();

  final RxBool isPasswordHidden = true.obs;
  var verificationId = ''.obs;
  var isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // Rx to hold our current user
  var firestoreUser = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    // listen to FirebaseAuth state changes
    auth.authStateChanges().listen(_setInitialScreen);
  }

  Future<void> fetchFirestoreUser() async {
    final uid = auth.currentUser?.uid;
    if (uid != null) {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        firestoreUser.value = UserModel.fromDoc(doc);
      }
    }
  }

  void _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAllNamed('/auth');
    } else {
      _loadFirestoreUser(user.uid);
    }
  }

  Future<void> _loadFirestoreUser(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    firestoreUser.value = UserModel.fromDoc(doc);
    Get.offAllNamed('/home');
  }

  /// Sign Up with email & password, upload profile image, then save to Firestore.
  Future<void> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      await _emailService.signUp(
        username: username,
        email: email,
        password: password,
      );
      await fetchFirestoreUser();
    } finally {
      isLoading.value = false;
    }
  }

  /// Sign In with email & password
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      await _emailService.signIn(email: email, password: password);
      await fetchFirestoreUser();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithPhone(String phoneNumber) async {
    try {
      isLoading.value = true;
      await _phoneService.signInWithPhone(phoneNumber);
      await fetchFirestoreUser();
    } finally {
      isLoading.value = false;
    }
  }

  String formatToE164(String input) {
    if (input.startsWith('0')) {
      return input.replaceFirst('0', '+855'); // Cambodia
    } else if (!input.startsWith('+')) {
      return '+855$input';
    }
    return input;
  }

  Future<void> verifyOTP(String otp) async {
    try {
      isLoading.value = false;
      await _phoneService.verifyOTP(otp);
      await fetchFirestoreUser();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      await _googleService.signInWithGoogle();
      await fetchFirestoreUser();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateUserPhotoUrl() async {
    try {
      isLoading.value = true;
      await _imageService.updateUserPhotoUrl();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOutUser() async {
    try {
      isLoading.value = true;
      await googleSignIn.signOut();

      await FirebaseAuth.instance.signOut(); // Firebase sign-out

      Get.offAllNamed('/auth');
      await favoriteController.fetchFavorites();
    } catch (e) {
      Get.snackbar("Authentication Error", "Error during sign-out: $e");
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
