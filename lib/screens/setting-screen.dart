import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../constants/app_images.dart';
import '../providers/image_picker_provider.dart';
import '../utils/app_utils.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/custom_size.dart';
import '../widgets/custom_text.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  late ImagePickerProvider imagePickerProvider;
  ValueNotifier<bool> saveNotifier = ValueNotifier<bool>(false);
  @override
  void initState() {
    imagePickerProvider =
        Provider.of<ImagePickerProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(
                color: AppColors.greyColor,
              ),
            ),
            height: height * 0.1,
            width: double.infinity,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Admin Panel',
                      style: TextStyle(
                        color: Color(0xFF424D57),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0x190174BE),
                            borderRadius: BorderRadius.circular(100)),
                        height: height * 0.07,
                        width: 40,
                        child: Center(
                          child: Text(
                            'H S',
                            style: const TextStyle(
                              color: Color(0xFF0174BE),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: Text(
                        'Huma Safdar',
                        style: const TextStyle(
                          color: Color(0xFF0C356A),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ])
                ])),
        const SizedBox(height: 20),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              child: Container(
                height: height,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Form(
                  key: formKey,
                  child: Stack(children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      child: SizedBox(
                        width: double.infinity,
                        height: 100,
                        child: Image.asset(
                          AppImages.rainbow,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      left: 70,
                      child: SizedBox(
                        height: 120,
                        width: 120,
                        child: Consumer<ImagePickerProvider>(
                          builder: (context, imageProvider, child) {
                            return SizedBox(
                              child: (imageProvider.getImageBytes.isNotEmpty)
                                  ? CircleAvatar(
                                      backgroundImage: MemoryImage(
                                          imageProvider.getImageBytes),
                                    )
                                  : (imagePickerProvider.getImageUrl != '')
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                imagePickerProvider.getImageUrl,
                                            progressIndicatorBuilder: (context,
                                                    url, progress) =>
                                                const CupertinoActivityIndicator(),
                                          ),
                                        )
                                      : const CircleAvatar(
                                          backgroundImage:
                                              AssetImage(AppImages.btsBoy),
                                        ),
                            );
                          },
                        ),
                      ),
                    ),
                    const Positioned(
                        top: 110,
                        left: 270,
                        child: CustomText(
                          label: 'Huma Safdar',
                          // '${firstNameController.text} ${lastNameController.text}',
                          size: 24,
                          weight: FontWeight.w700,
                        )),
                    Positioned(
                      top: 155,
                      left: 57,
                      right: 57,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            InkWell(
                                onTap: () async {
                                  await AppUtils.pickImage(context: context)
                                      .then((image) async {
                                    imagePickerProvider.setImageBytes = image;
                                  });
                                },
                                child: const CustomText(
                                  label: 'Change',
                                  color: AppColors.red,
                                  size: 16,
                                  weight: FontWeight.w400,
                                )),
                            const CustomSize(width: 40),
                            if (imagePickerProvider.getImageUrl != '')
                              InkWell(
                                // onTap: () async {
                                //   await AuthServices.deleteImageUrl()
                                //       .then((value) => imagePickerProvider
                                //           .setImageUrl = '');
                                //   // toastMessage('Deleted');
                                //   imagePickerProvider.setImageBytes =
                                //       Uint8List(0);
                                // },
                                child: const CustomText(
                                  label: 'Delete',
                                  color: AppColors.red,
                                  size: 16,
                                  weight: FontWeight.w400,
                                ),
                              )
                          ]),
                          Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: Row(
                              children: [
                                buildText('Email ID'),
                                CustomSize(width: width * 0.3),
                                buildText('First Name'),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: height * 0.1,
                                    width: width * 0.23,
                                    child: CustomInputField(
                                      labelText: 'Email',
                                      controller: emailController,
                                      //  readOnly: true,
                                    ),
                                  ),
                                ),
                                const CustomSize(width: 30),
                                Expanded(
                                  child: SizedBox(
                                    height: height * 0.1,
                                    width: width * 0.23,
                                    child: CustomInputField(
                                      controller: firstNameController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter correct name';
                                        } else {
                                          return null;
                                        }
                                      },
                                      labelText: 'First Name',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: Row(
                              children: [
                                buildText('Last Name'),
                                CustomSize(width: width * 0.285),
                                buildText('Phone No'),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                      height: height * 0.1,
                                      width: width * 0.23,
                                      child: CustomInputField(
                                        labelText: 'Last Name',
                                        validator: (value) {
                                          if (value!.length < 2) {
                                            return 'Enter correct name';
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller: lastNameController,
                                      )),
                                ),
                                const CustomSize(width: 30),
                                Expanded(
                                  child: SizedBox(
                                      height: height * 0.1,
                                      width: width * 0.23,
                                      child: CustomInputField(
                                        labelText: 'Phone Number',
                                        controller: phoneController,
                                        validator: (value) {
                                          if (value!.length < 2) {
                                            return 'Enter valid phone number';
                                          } else {
                                            return null;
                                          }
                                        },
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: buildText('Address'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: SizedBox(
                              height: height * 0.1,
                              width: width * 0.32,
                              child: CustomInputField(
                                controller: addressController,
                                labelText: 'Address',
                                validator: (value) {
                                  if (value!.length < 2) {
                                    return 'Enter correct address';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: SizedBox(
                                height: height * 0.07,
                                width: 100,
                                child: Consumer<ImagePickerProvider>(
                                  builder: (context, networkImage, child) =>
                                      ValueListenableBuilder(
                                    valueListenable: saveNotifier,
                                    builder: (context, value, child) {
                                      return CustomButton(
                                        isLoading: value,
                                        onPressed: () async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            saveNotifier.value = true;
                                            // if (imagePickerProvider
                                            //     .getImageBytes.isNotEmpty) {
                                            //   imagePickerProvider
                                            //           .setImageUrl =
                                            //       await AuthServices
                                            //           .storeImageToFirebase(
                                            //               context: context,
                                            //               image: imagePickerProvider
                                            //                   .getImageBytes);
                                            // }
                                          }
                                        },
                                        text: 'SAVE',
                                        color: AppColors.red,
                                        textColor: AppColors.white,
                                      );
                                    },
                                  ),
                                )),
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              ),
            ),
          ),
        ))
      ],
    );
  }

  Widget buildText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.red,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
