import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../constants/app_colors.dart';
import '../constants/app_text.dart';
import '../widgets/custom_container.dart';
import '../widgets/custom_display_image.dart';
import '../widgets/custom_size.dart';
import '../widgets/custom_snackbar.dart';
import '../widgets/custom_text.dart';

class AppUtils {
  static CollectionReference fireStoreRef() {
    CollectionReference reference =
        FirebaseFirestore.instance.collection('products');
    return reference;
  }

  static Reference storageRef() {
    Reference storageRef =
        FirebaseStorage.instance.ref().child(AppText.mainCollectionRef);
    return storageRef;
  }

  static Future<Uint8List?> pickImage({required BuildContext context}) async {
    if (!kIsWeb) {
      final picker = ImagePicker();
      XFile? mediaFile = await picker.pickImage(source: ImageSource.gallery);

      if (mediaFile != null) {
        Uint8List file = await mediaFile.readAsBytes();
        return file;
      } else {
        SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
          CustomSnackBar.showSnackBar(
              context: context, message: 'No file selected', isError: true);
        });
        return null;
      }
    }
    return null;
  }

  static String getUniqueID() {
    Uuid uid = const Uuid();
    return uid.v4();
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM_RIGHT,
        webBgColor: '#000000',
        textColor: AppColors.red,
        fontSize: 16.0);
  }

  Widget _productContainer({
    String? imagePath,
    String? title,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
    String? subTitle,
  }) {
    return CustomContainer(
      borderColor: Colors.grey.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
                width: double.infinity,
                child: ImageView(
                  imageUrl: imagePath!,
                )),
          ),
          const CustomSize(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  label: '$title',
                  color: AppColors.darkGrey,
                ),
                const CustomSize(
                  height: 5,
                ),
                CustomText(
                  label: '$subTitle',
                  color: AppColors.black,
                ),
                const CustomSize(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: onEdit,
                          child: CustomContainer(
                            height: 25,
                            borderColor: Colors.grey.withOpacity(0.3),
                            color: AppColors.white,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: AppColors.darkGrey,
                                  size: 15,
                                ),
                                CustomSize(
                                  width: 5,
                                ),
                                CustomText(
                                  label: 'Edit',
                                  weight: FontWeight.w700,
                                  size: 10,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const CustomSize(
                        width: 10,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: onDelete,
                          child: CustomContainer(
                            height: 25,
                            borderColor: Colors.grey.withOpacity(0.3),
                            color: AppColors.white,
                            child: const Center(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.delete,
                                        color: Colors.red, size: 15),
                                    CustomText(
                                      label: 'Delete',
                                      size: 10,
                                      color: Colors.red,
                                    )
                                  ]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const CustomSize(
                  height: 10,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
