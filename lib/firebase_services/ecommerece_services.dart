import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/ecommerce_product_model.dart';

class EcommerceServices {
  static Future<void> uploadProducts(
      {required EcommerceProductModel productModel,
      required String docId}) async {
    FirebaseFirestore.instance.collection('products').doc(docId).set(
          productModel.toJson(),
        );
  }

  // static Future<void> updateProduct({
  //   required EcommerceProductModel productModel,
  //   required BuildContext context,
  // }) async {
  //   log('................................  call......${productModel.id}......................}');
  //   try {
  //     QuerySnapshot<Map<String, dynamic>> reference =
  //         await AppUtils.fireStoreRef()
  //             .doc(AppText.ecommerceCollectionRef)
  //             .collection(AppText.products)
  //             .where('id', isEqualTo: productModel.id)
  //             .get();
  //     DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
  //         reference.docs.reversed.first;
  //     await documentSnapshot.reference
  //         .update(productModel.toJson())
  //         .then((value) {
  //       CustomSnackBar.showSnackBar(
  //         context: context,
  //         message: AppText.updateMessage,
  //       );
  //     });
  //   } on FirebaseException catch (error) {
  //     SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
  //       CustomSnackBar.showSnackBar(
  //           context: context, message: error.toString(), isError: true);
  //     });
  //   }
  // }
}
