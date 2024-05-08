import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../utils/app_utils.dart';
import '../widgets/custom_snackbar.dart';

class ApiServices {
  static Future<String?> uploadOrUpdateImage(
      {required Uint8List? imageBytes,
      required String imageId,
      bool isVideo = false,
      required BuildContext context}) async {
    return null;
  }

  static Future<bool?> deleteProductImage(
      {required String reference,
      required String imageId,
      required BuildContext context}) async {
    try {
      Reference ref = AppUtils.storageRef().child('$reference/images/$imageId');
      await ref.delete();
      return true;
    } on FirebaseException catch (error) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        CustomSnackBar.showSnackBar(
            context: context, message: error.toString(), isError: true);
      });
    }
    return null;
  }
}
