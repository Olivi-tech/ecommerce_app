import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../constants/app_colors.dart';
import '../constants/app_images.dart';

class ShowDeleteDialog {
  static void showDeleteDialog(
      {required BuildContext context, VoidCallback? deleteButton}) {
    AwesomeDialog(
      customHeader: const CircleAvatar(
        backgroundColor: AppColors.white,
        backgroundImage: AssetImage(AppImages.danger),
        radius: 40,
      ),
      showCloseIcon: true,
      width: 400,
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.rightSlide,
      title: 'Delete ',
      desc: 'would you want to delete product',
      btnCancelText: 'No',
      btnOkText: 'Yes',
      btnCancelOnPress: () {
        Navigator.pop(context);
      },
      btnOkOnPress: deleteButton,
    ).show();
  }
}
