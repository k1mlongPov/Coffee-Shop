import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var isUploading = false.obs;
  var profileImageUrl = ''.obs;

  Future<void> pickAndUploadProfileImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    isUploading.value = true;
    try {
      final user = _auth.currentUser;
      final File file = File(pickedFile.path);

      // Upload to Firebase Storage
      final ref = _storage.ref().child('profile_pictures/${user!.uid}.jpg');
      await ref.putFile(file);

      // Get Download URL
      final downloadUrl = await ref.getDownloadURL();

      // Update Firestore
      await _firestore.collection('users').doc(user.uid).set({
        'email': user.email,
        'username': user.displayName ?? 'default_username',
        'photoUrl': downloadUrl,
      }, SetOptions(merge: true));

      profileImageUrl.value = downloadUrl;

      Get.snackbar('Success', 'Profile photo updated!');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isUploading.value = false;
    }
  }
}
