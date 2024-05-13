import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerece_admin_panel/firebase_services/api_services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import '../constants/app_text.dart';
import '../models/ecommerce_product_model.dart';
import '../utils/utils.dart';
import '../widgets/custom_snackbar.dart';

class EcommerceServices {
  static final fireStore = FirebaseFirestore.instance;
  static Future<void> uploadProducts(
      {required EcommerceProductModel productModel,
      required String docId}) async {
    FirebaseFirestore.instance.collection('products').doc(docId).set(
          productModel.toJson(),
        );
  }

  static Stream<List<EcommerceProductModel>> fetchProducts() {
    return fireStore.collection('products').snapshots().map((query) {
      return query.docs
          .map((doc) => EcommerceProductModel.fromJson(jsonData: doc.data()))
          .toList();
    });
  }

  static Future<void> deleteProduct({
    required String productId,
    required BuildContext context,
  }) async {
    try {
      await ApiServices.deleteProductImage(
          context: context, imageId: productId);
      DocumentReference reference = FirebaseFirestore.instance
          .collection(AppText.products)
          .doc(productId);
      await reference.delete().then((value) {
        AppUtils.toastMessage(AppText.deleteMessage);
      });
    } on FirebaseException catch (error) {
      ;
    }
  }

  static Future<void> updateProduct({
    required EcommerceProductModel productModel,
    required BuildContext context,
    required String productID,
  }) async {
    try {
      // Get a reference to the document
      DocumentReference<Map<String, dynamic>> documentRef =
          FirebaseFirestore.instance.collection('products').doc(productID);

      // Update the document with the new data
      await documentRef.update(productModel.toJson());

      // If the update is successful, show a success message
      CustomSnackBar.showSnackBar(
        context: context,
        message: AppText.updateMessage,
      );
    } catch (error) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        CustomSnackBar.showSnackBar(
          context: context,
          message: error.toString(),
          isError: true,
        );
      });
    }
  }

  static Stream<List<String>> fetchCatagory() {
    return fireStore.collection('products').snapshots().map((query) {
      return query.docs
          .map((doc) => doc.data()['category'].toString())
          .toList();
    });
  }
}
