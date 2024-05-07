import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../utils/app_utils.dart';

class AuthServices {
  static User get getCurrentUser {
    return FirebaseAuth.instance.currentUser!;
  }

  static Future<bool> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        log('...........................userlogin');
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ));
        return true;
      }
      log('..............NotLogin');
    } on FirebaseAuthException catch (e) {
      log('....................NotLogin......${e.message}.${e.code}............ex');
      if (e.message!.contains('user-not-found')) {
        return false;
      } else if (e.message!.contains('wrong-password')) {
        AppUtils.toastMessage('Wrong password provided for that user.');
        return false;
      }
      return false;
    }
    return false;
  }
}
