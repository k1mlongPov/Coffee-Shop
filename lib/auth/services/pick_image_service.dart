import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PickImageService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;

  // Pick image from gallery
  Future<File?> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  // Upload image to Firebase Storage and return the download URL
  Future<String?> uploadProfileImage(File imageFile) async {
    try {
      isLoading.value = true;
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return null;

      final ref =
          FirebaseStorage.instance.ref().child('profile_pictures/$uid.jpg');

      final uploadTask = ref.putFile(imageFile);

      // Wait for upload to complete
      await uploadTask.whenComplete(() => null);

      // Get the download URL
      final url = await ref.getDownloadURL();
      print("Image uploaded. URL: $url");
      return url;
    } catch (e) {
      e.printError();
      isLoading.value = false;
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  // Update user's photoUrl in Firestore
  Future<void> updateUserPhotoUrl() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final imageFile = await pickImage();
    if (imageFile == null) return;

    final photoUrl = await uploadProfileImage(imageFile);
    if (photoUrl == null) return;

    await _firestore.collection('users').doc(uid).update({
      'photoUrl': photoUrl,
    });

    print("Photo URL updated in Firestore: $photoUrl");
  }
}
