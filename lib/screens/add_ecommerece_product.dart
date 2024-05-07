import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../models/ecommerce_product_model.dart';
import '../../utils/app_utils.dart';
import '../constants/app_colors.dart';
import '../constants/app_text.dart';
import '../firebase_services/api_services.dart';
import '../firebase_services/ecommerece_services.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_container.dart';
import '../widgets/custom_display_image.dart';
import '../widgets/custom_drop_down.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/custom_size.dart';
import '../widgets/custom_text.dart';

class AddEcommerceProduct extends StatefulWidget {
  final EcommerceProductModel? ecommerceProductModel;
  const AddEcommerceProduct({super.key, this.ecommerceProductModel});
  @override
  State<AddEcommerceProduct> createState() => _AddEcommerceProductState();
}

class _AddEcommerceProductState extends State<AddEcommerceProduct> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _productCodeController = TextEditingController();
  final TextEditingController _deliveryChargesController =
      TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  ValueNotifier<Uint8List?> imageBytesNotifier =
      ValueNotifier(Uint8List.fromList([]));
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);
  String imageUrl = '';
  ValueNotifier<String> selectedValueNotifier = ValueNotifier('All');
  @override
  void initState() {
    if (widget.ecommerceProductModel != null) {
      _titleController.text = widget.ecommerceProductModel!.title!;
      _priceController.text = widget.ecommerceProductModel!.price!.toString();
      _descriptionController.text = widget.ecommerceProductModel!.description!;
      _categoryController.text = widget.ecommerceProductModel!.category!;
      _deliveryChargesController.text =
          widget.ecommerceProductModel!.deliveryCharges!.toString();
      _discountController.text =
          widget.ecommerceProductModel!.discount!.toString();
      _productCodeController.text = widget.ecommerceProductModel!.productCode!;
      imageUrl = widget.ecommerceProductModel!.imageUrl!;
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
          automaticallyImplyLeading: true,
          title: const CustomText(
            label: 'Ecommerce',
            weight: FontWeight.w600,
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
                              label: 'Product title',
                              size: 12,
                              weight: FontWeight.w400,
                            ),
                            const CustomSize(
                              height: 5,
                            ),
                            CustomInputField(
                                maxLine: 1,
                                controller: _titleController,
                                labelText: 'Product title',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a product title';
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
                              height: 10,
                            ),
                            const CustomText(
                                label: 'Image',
                                size: 12,
                                weight: FontWeight.w400),
                            const CustomSize(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const CustomSize(
                                  width: 5,
                                ),
                                ValueListenableBuilder(
                                  valueListenable: imageBytesNotifier,
                                  builder: (context, image, child) =>
                                      CustomImageDisplay(
                                    imageFile: imageBytesNotifier.value,
                                    imageUrl:
                                        imageUrl /*widget.ecommerceProductModel.imageUrl*/,
                                  ),
                                ),
                                const CustomSize(
                                  width: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    AppUtils.pickImage(context: context)
                                        .then((imageBytes) {
                                      imageBytesNotifier.value = imageBytes;
                                    });
                                  },
                                  child: CustomContainer(
                                    height: 45,
                                    width: 45,
                                    borderColor: Colors.grey.withOpacity(0.3),
                                    color: AppColors.greyColor,
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.cloud_upload,
                                            color: AppColors.darkGrey,
                                            size: 15,
                                          ),
                                          CustomText(
                                            label: 'Upload',
                                            size: 6,
                                            color: AppColors.darkGrey,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
                                        String productId =
                                            widget.ecommerceProductModel != null
                                                ? widget
                                                    .ecommerceProductModel!.id!
                                                : AppUtils.getUniqueID();
                                        if (imageBytesNotifier.value != null &&
                                            imageBytesNotifier
                                                .value!.isNotEmpty) {
                                          imageUrl = (await ApiServices
                                              .uploadOrUpdateImage(
                                                  context: context,
                                                  imageBytes:
                                                      imageBytesNotifier.value,
                                                  reference: AppText
                                                      .ecommerceCollectionRef,
                                                  imageId: productId))!;
                                        }
                                        EcommerceProductModel product =
                                            EcommerceProductModel(
                                                title: _titleController.text,
                                                id: widget.ecommerceProductModel != null
                                                    ? widget.ecommerceProductModel!
                                                        .id
                                                    : productId,
                                                category:
                                                    _categoryController.text,
                                                description:
                                                    _descriptionController.text,
                                                price: double.parse(
                                                    _priceController.text),
                                                soldCount: 0,
                                                deliveryCharges: double.parse(
                                                    _deliveryChargesController
                                                        .text),
                                                discount: double.parse(
                                                    _discountController.text),
                                                productCode:
                                                    _productCodeController.text,
                                                imageUrl: imageUrl);
                                        SchedulerBinding.instance
                                            .addPostFrameCallback((timeStamp) {
                                          if (widget.ecommerceProductModel !=
                                              null) {
                                            EcommerceServices.updateProduct(
                                                    productModel: product,
                                                    context: context)
                                                .then((value) {
                                              isLoadingNotifier.value = false;
                                            });
                                          } else {
                                            // ignore: use_build_context_synchronously
                                            EcommerceServices.uploadProduct(
                                                    productModel: product,
                                                    context: context,
                                                    productId: productId)
                                                .then((value) {
                                              isLoadingNotifier.value = false;
                                            });
                                          }
                                        });

                                        // ignore: use_build_context_synchronously
                                        Navigator.pop(context);
                                      }
                                    },
                                    text: widget.ecommerceProductModel == null
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
