import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../constants/app_colors.dart';
import '../constants/app_text.dart';
import '../widgets/custom_snackbar.dart';

class AppUtils {
  static CollectionReference fireStoreRef() {
    CollectionReference reference =
        FirebaseFirestore.instance.collection(AppText.mainCollectionRef);
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
    Uuid uid = Uuid();
    return uid.v4();
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM_RIGHT,
        webBgColor: '#000000',
        textColor: AppColors.red,
        fontSize: 16.0);
  }
}
