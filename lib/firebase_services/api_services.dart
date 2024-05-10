import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../utils/app_utils.dart';
import '../widgets/custom_snackbar.dart';

class ApiServices {
  static Future<bool?> deleteProductImage(
      {required String imageId, required BuildContext context}) async {
    try {
      Reference ref = AppUtils.storageRef().child('');
      await ref.delete();
      return true;
    } on FirebaseException catch (error) {
      ;
    }
    return null;
  }
}
