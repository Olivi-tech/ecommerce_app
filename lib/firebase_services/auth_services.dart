import 'dart:developer';
import 'package:e_commerece_admin_panel/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import '../screens/home_screen.dart';

class AuthServices {
  static User get getCurrentUser {
    return FirebaseAuth.instance.currentUser!;
  }

  static Future<bool> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    log('...............................run login...............');
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        log('..........................user Login');

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
        ;
        return true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AppUtils.toastMessage('No user found for that email.');
        log('...................................dekkwkwkwsdnnnnnnnnnnnnn');
        return false;
      } else if (e.code == 'wrong-password') {
        AppUtils.toastMessage('Wrong password provided for that user.');
        return false;
      }
      return false;
    }
    return false;
  }

  static Future<Uint8List?> getImageFromGallery(
      {required BuildContext context}) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Uint8List image = await pickedFile.readAsBytes();
      return image;
    } else {
      return null;
    }
  }

  static Future<String> storeProductsImageToFirebase(
      {required BuildContext context, required Uint8List image}) async {
    final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    final profileImage = firebaseStorage
        .ref('product_images')
        .child("${DateTime.timestamp().millisecondsSinceEpoch}");
    try {
      await profileImage.putData(
          image, SettableMetadata(contentType: "image/png"));
      return await profileImage.getDownloadURL();
    } on FirebaseException catch (error) {
      log('Image Uploading Error:$error ');
      return '';
    }
  }
}
