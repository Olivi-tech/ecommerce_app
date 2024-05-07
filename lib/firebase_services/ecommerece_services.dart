import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

import '../constants/app_text.dart';
import '../models/ecommerce_product_model.dart';
import '../utils/app_utils.dart';
import '../widgets/custom_snackbar.dart';
import 'api_services.dart';

class EcommerceServices {
  static Future<void> uploadProduct({
    required EcommerceProductModel productModel,
    required BuildContext context,
    required String productId,
  }) async {
    try {
      DocumentReference reference = AppUtils.fireStoreRef()
          .doc(AppText.ecommerceCollectionRef)
          .collection(AppText.products)
          .doc(productId);
      await reference
          .set(productModel.toJson(), SetOptions(merge: true))
          .then((value) {
        CustomSnackBar.showSnackBar(
          context: context,
          message: AppText.successMessage,
        );
      });
    } on FirebaseException catch (error) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        CustomSnackBar.showSnackBar(
            context: context, message: error.toString(), isError: true);
      });
    }
  }

  static Future<void> updateProduct({
    required EcommerceProductModel productModel,
    required BuildContext context,
  }) async {
    log('................................  call......${productModel.id}......................}');
    try {
      QuerySnapshot<Map<String, dynamic>> reference =
          await AppUtils.fireStoreRef()
              .doc(AppText.ecommerceCollectionRef)
              .collection(AppText.products)
              .where('id', isEqualTo: productModel.id)
              .get();
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          reference.docs.reversed.first;
      await documentSnapshot.reference
          .update(productModel.toJson())
          .then((value) {
        CustomSnackBar.showSnackBar(
          context: context,
          message: AppText.updateMessage,
        );
      });
    } on FirebaseException catch (error) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        CustomSnackBar.showSnackBar(
            context: context, message: error.toString(), isError: true);
      });
    }
  }
}
