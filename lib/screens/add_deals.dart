import 'package:e_commerece_admin_panel/constants/app_colors.dart';
import 'package:e_commerece_admin_panel/constants/app_text.dart';
import 'package:e_commerece_admin_panel/firebase_services/auth_services.dart';
import 'package:e_commerece_admin_panel/firebase_services/ecommerece_services.dart';
import 'package:e_commerece_admin_panel/models/deals_model.dart';
import 'package:e_commerece_admin_panel/providers/image_picker_provider.dart';
import 'package:e_commerece_admin_panel/utils/app_utils.dart';
import 'package:e_commerece_admin_panel/widgets/custom_button.dart';
import 'package:e_commerece_admin_panel/widgets/custom_container.dart';
import 'package:e_commerece_admin_panel/widgets/custom_drop_down.dart';
import 'package:e_commerece_admin_panel/widgets/custom_input_field.dart';
import 'package:e_commerece_admin_panel/widgets/custom_size.dart';
import 'package:e_commerece_admin_panel/widgets/custom_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CreateDeals extends StatefulWidget {
  final EcommerceDealsModel? ecommerceDealsModel;
  const CreateDeals({super.key, this.ecommerceDealsModel});

  @override
  State<CreateDeals> createState() => _CreateDealsState();
}

class _CreateDealsState extends State<CreateDeals> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _productCodeController = TextEditingController();
  final TextEditingController _deliveryChargesController =
      TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  late ImagePickerProvider imagePickerProvider;
  ValueNotifier<Uint8List?> imageBytesNotifier =
      ValueNotifier(Uint8List.fromList([]));
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);

  ValueNotifier<String> selectedValueNotifier = ValueNotifier('All');
  @override
  void initState() {
    imagePickerProvider =
        Provider.of<ImagePickerProvider>(context, listen: false);
    if (widget.ecommerceDealsModel != null) {
      print('the image is ${widget.ecommerceDealsModel!.imageUrl!} ');
      imagePickerProvider.setImageUrl = widget.ecommerceDealsModel!.imageUrl!;
      _titleController.text = widget.ecommerceDealsModel!.title!;
      _priceController.text = widget.ecommerceDealsModel!.price!.toString();
      _descriptionController.text = widget.ecommerceDealsModel!.description!;
      _categoryController.text = widget.ecommerceDealsModel!.category!;
      _deliveryChargesController.text =
          widget.ecommerceDealsModel!.deliveryCharges!.toString();
      _discountController.text =
          widget.ecommerceDealsModel!.discount!.toString();
      _productCodeController.text = widget.ecommerceDealsModel!.productCode!;
      _durationController.text = widget.ecommerceDealsModel!.duration!;
    }
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.greyColor,
      appBar: AppBar(
          backgroundColor: AppColors.red,
          automaticallyImplyLeading: false,
          title: SizedBox(
            width: width * 0.15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    imagePickerProvider.clear();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: AppColors.white,
                  ),
                ),
                const CustomText(
                  label: 'Deals',
                  color: AppColors.white,
                  weight: FontWeight.w600,
                ),
              ],
            ),
          )),
      body: Form(
        key: _formKey,
        child: SizedBox(
          height: height,
          child: Column(
            children: [
              Expanded(
                  child: Center(
                child: CustomContainer(
                  borderColor: Colors.transparent,
                  height: height * 0.85,
                  width: width * 0.4,
                  color: AppColors.white,
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomSize(
                              height: 10,
                            ),
                            const CustomText(
                              label: 'Deal title',
                              color: AppColors.black,
                              size: 12,
                              weight: FontWeight.w400,
                            ),
                            const CustomSize(
                              height: 5,
                            ),
                            CustomInputField(
                                maxLine: 1,
                                controller: _titleController,
                                labelText: 'Deal title',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a Deal title';
                                  }
                                  return null;
                                }),
                            const CustomSize(
                              height: 15,
                            ),
                            const CustomText(
                              label: 'Description',
                              size: 12,
                              weight: FontWeight.w400,
                            ),
                            const CustomSize(
                              height: 5,
                            ),
                            CustomInputField(
                                maxLine: 3,
                                controller: _descriptionController,
                                labelText: 'Description',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a description';
                                  }
                                  return null;
                                }),
                            const CustomSize(
                              height: 15,
                            ),
                            const CustomText(
                              label: 'Duration',
                              size: 12,
                              weight: FontWeight.w400,
                            ),
                            const CustomSize(
                              height: 5,
                            ),
                            CustomInputField(
                                maxLine: 1,
                                controller: _durationController,
                                labelText: 'Duration',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a duration';
                                  }
                                  return null;
                                }),
                            const CustomSize(
                              height: 10,
                            ),
                            const CustomText(
                                label: 'Image',
                                size: 12,
                                weight: FontWeight.w400),
                            Align(
                              alignment: Alignment.center,
                              child: Consumer<ImagePickerProvider>(
                                builder: (context, imageprovider, child) {
                                  return Container(
                                    height: height * 0.25,
                                    width: width * 0.3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: AppColors.darkGrey,
                                            width: 1)),
                                    child: imagePickerProvider
                                            .getImageUrl.isNotEmpty
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                SizedBox(
                                                  width: width,
                                                  child: Image.network(
                                                    imageprovider.getImageUrl,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    AuthServices
                                                            .getImageFromGallery(
                                                                context:
                                                                    context)
                                                        .then((image) async {
                                                      imagePickerProvider
                                                          .setImageUrl = '';
                                                      imagePickerProvider
                                                              .setImageBytes =
                                                          image;
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.add_a_photo_outlined,
                                                    color: AppColors.darkGrey,
                                                    size: 30,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : imagePickerProvider
                                                .getImageBytes.isNotEmpty
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width: width,
                                                      child: Image.memory(
                                                        imageprovider
                                                            .getImageBytes,
                                                        fit: BoxFit.fitWidth,
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        AuthServices
                                                                .getImageFromGallery(
                                                                    context:
                                                                        context)
                                                            .then(
                                                                (image) async {
                                                          imagePickerProvider
                                                                  .setImageBytes =
                                                              image;
                                                        });
                                                      },
                                                      child: const Icon(
                                                        Icons
                                                            .add_a_photo_outlined,
                                                        size: 30,
                                                        color:
                                                            AppColors.darkGrey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const SizedBox(
                                                    height: 35,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      AuthServices
                                                              .getImageFromGallery(
                                                                  context:
                                                                      context)
                                                          .then((image) async {
                                                        imagePickerProvider
                                                                .setImageBytes =
                                                            image;
                                                      });
                                                    },
                                                    child: const Icon(
                                                      Icons
                                                          .add_a_photo_outlined,
                                                      size: 30,
                                                      color: AppColors.darkGrey,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  const CustomText(
                                                    color: AppColors.darkGrey,
                                                    weight: FontWeight.w500,
                                                    label:
                                                        ' Add produt image thumbnail',
                                                  )
                                                ],
                                              ),
                                  );
                                },
                              ),
                            ),
                            const CustomSize(
                              width: 5,
                            ),
                            const CustomSize(
                              height: 10,
                            ),
                            const CustomText(
                                label: 'Category',
                                size: 12,
                                weight: FontWeight.w400),
                            const CustomSize(
                              height: 5,
                            ),
                            Center(
                              child: CustomDropDown(
                                options: AppText
                                    .ecommerceLabels, // Your dropdown options
                                selectedValue: selectedValueNotifier,
                                controller: _categoryController,
                              ),
                            ),
                            const CustomSize(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CustomText(
                                          label: 'Price',
                                          size: 12,
                                          weight: FontWeight.w400),
                                      const CustomSize(
                                        height: 5,
                                      ),
                                      CustomInputField(
                                          maxLine: 1,
                                          controller: _priceController,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9]')),
                                          ],
                                          labelText: 'Price',
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter price';
                                            }
                                            return null;
                                          }),
                                    ],
                                  ),
                                ),
                                const CustomSize(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CustomText(
                                          label: 'Discount',
                                          size: 12,
                                          weight: FontWeight.w400),
                                      const CustomSize(
                                        height: 5,
                                      ),
                                      CustomInputField(
                                          maxLine: 1,
                                          controller: _discountController,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9]')),
                                          ],
                                          labelText: 'Discount',
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter discount';
                                            }
                                            return null;
                                          }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const CustomSize(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CustomText(
                                          label: 'Code',
                                          size: 12,
                                          weight: FontWeight.w400),
                                      const CustomSize(
                                        height: 5,
                                      ),
                                      CustomInputField(
                                          maxLine: 1,
                                          controller: _productCodeController,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9]')),
                                          ],
                                          labelText: 'Code',
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter code';
                                            }
                                            return null;
                                          }),
                                    ],
                                  ),
                                ),
                                const CustomSize(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CustomText(
                                          label: 'Delivery charges',
                                          size: 12,
                                          weight: FontWeight.w400),
                                      const CustomSize(
                                        height: 5,
                                      ),
                                      CustomInputField(
                                          maxLine: 1,
                                          controller:
                                              _deliveryChargesController,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9]')),
                                          ],
                                          labelText: 'Delivery charges',
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter delivery charges';
                                            }
                                            return null;
                                          }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const CustomSize(
                              height: 30,
                            ),
                            ValueListenableBuilder(
                              valueListenable: isLoadingNotifier,
                              builder: (context, isLoading, child) => Center(
                                child: CustomButton(
                                    width: 150,
                                    isLoading: isLoading,
                                    color: AppColors.red,
                                    textColor: AppColors.white,
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        isLoadingNotifier.value = true;

                                        bool isImageUpdated = widget
                                                .ecommerceDealsModel
                                                ?.imageUrl !=
                                            imagePickerProvider.getImageUrl;
                                        // If image is updated, upload the new image
                                        if (isImageUpdated) {
                                          imagePickerProvider.setImageUrl =
                                              await AuthServices
                                                  .storeDealsImageToFirebase(
                                                      context: context,
                                                      image: imagePickerProvider
                                                          .getImageBytes);
                                        }
                                        String productId =
                                            widget.ecommerceDealsModel != null
                                                ? widget
                                                    .ecommerceDealsModel!.docId!
                                                : AppUtils.getUniqueID();
                                        EcommerceDealsModel dealsModel =
                                            EcommerceDealsModel(
                                          duration: _durationController.text,
                                          title: _titleController.text,
                                          docId: productId,
                                          category: _categoryController.text,
                                          description:
                                              _descriptionController.text,
                                          price: double.parse(
                                              _priceController.text),
                                          deliveryCharges: double.parse(
                                              _deliveryChargesController.text),
                                          discount: double.parse(
                                              _discountController.text),
                                          productCode:
                                              _productCodeController.text,
                                          imageUrl: isImageUpdated
                                              ? imagePickerProvider.getImageUrl
                                              : widget.ecommerceDealsModel
                                                      ?.imageUrl ??
                                                  '',
                                        );
                                        SchedulerBinding.instance!
                                            .addPostFrameCallback((timeStamp) {
                                          if (widget.ecommerceDealsModel !=
                                              null) {
                                            if (isImageUpdated) {
                                              // Delete the previous image from Firebase Storage if it's not the default placeholder image
                                              if (widget.ecommerceDealsModel!
                                                          .imageUrl !=
                                                      null &&
                                                  widget.ecommerceDealsModel!
                                                          .imageUrl !=
                                                      '') {
                                                AuthServices
                                                    .deleteImageFromFirebaseStorage(
                                                        widget
                                                            .ecommerceDealsModel!
                                                            .imageUrl!);
                                              }
                                              // Update the product with the new image URL
                                              EcommerceServices.updateDeals(
                                                      dealModel: dealsModel,
                                                      dealsID:
                                                          dealsModel.docId!,
                                                      context: context)
                                                  .then((value) {
                                                isLoadingNotifier.value = false;
                                              });
                                            } else {
                                              // If image is not updated, directly update other product details
                                              EcommerceServices.updateDeals(
                                                      dealModel: dealsModel,
                                                      dealsID:
                                                          dealsModel.docId!,
                                                      context: context)
                                                  .then((value) {
                                                isLoadingNotifier.value = false;
                                                AppUtils.toastMessage(
                                                    'Deals updated successfully');

                                                imagePickerProvider
                                                    .setImageUrl = '';
                                                widget.ecommerceDealsModel!
                                                    .imageUrl = '';
                                              });
                                            }
                                          } else {
                                            // Upload the new product with the image
                                            EcommerceServices.uploadDeals(
                                                    dealsModel: dealsModel,
                                                    docId: productId)
                                                .then((value) {
                                              AppUtils.toastMessage(
                                                  'Deals created successfully');

                                              isLoadingNotifier.value = false;
                                              imagePickerProvider.setImageUrl =
                                                  '';
                                              widget.ecommerceDealsModel!
                                                  .imageUrl = '';
                                            });
                                          }
                                          Navigator.pop(context);
                                        });
                                      }
                                    },
                                    text: widget.ecommerceDealsModel == null
                                        ? 'Add'
                                        : 'Update'),
                              ),
                            ),
                            const CustomSize(
                              height: 12,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
