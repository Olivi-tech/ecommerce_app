import 'dart:developer';
import 'package:e_commerece_admin_panel/firebase_services/ecommerece_services.dart';
import 'package:e_commerece_admin_panel/providers/clear_All_provider.dart';
import 'package:e_commerece_admin_panel/providers/image_picker_provider.dart';
import 'package:e_commerece_admin_panel/screens/e_commerce.dart';
import 'package:e_commerece_admin_panel/utils/show_delete_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../constants/custom_appbar.dart';
import '../models/ecommerce_product_model.dart';
import '../providers/drop_down_provider.dart';
import '../widgets/custom_container.dart';
import '../widgets/custom_display_image.dart';
import '../widgets/custom_drop_down.dart';
import '../widgets/custom_size.dart';
import '../widgets/custom_text.dart';
import '../widgets/drop_down_widget.dart';
import 'add_ecommerece_product.dart';

class EcommerceScreen extends StatefulWidget {
  const EcommerceScreen({super.key});
  @override
  State<EcommerceScreen> createState() => _EcommerceScreenState();
}

TextEditingController searchController = TextEditingController();
late Stream<List<EcommerceProductModel>> fetchProducts;
late ImagePickerProvider pickerProvider;
late EcommerceProductModel? ecommerceProductModel;
late SearchProvider searchProvider;
ValueNotifier<String> searchNotifier = ValueNotifier<String>('');
TextEditingController controller = TextEditingController();
List<EcommerceProductModel> filterEventData = [];
List<EcommerceProductModel> eventData = [];
ValueNotifier<String> selectedValueNotifier = ValueNotifier('All');
late Stream<List<String>> catagory = EcommerceServices.fetchCatagory();
late ImagePickerProvider imagePickerProvider;

class _EcommerceScreenState extends State<EcommerceScreen> {
  @override
  void initState() {
    imagePickerProvider =
        Provider.of<ImagePickerProvider>(context, listen: false);
    searchProvider = Provider.of<SearchProvider>(context, listen: false);
    fetchProducts = EcommerceServices.fetchProducts();
    pickerProvider = Provider.of<ImagePickerProvider>(context, listen: false);

    super.initState();
  }

  @override
  void dispose() {
    imagePickerProvider.setImageUrl = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    print('the width is $width');
    double mainAxisExtent = width < 720 ? 210 : 200;
    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 4,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AddEcommerceProduct(),
                                  ));
                            },
                            child: const CustomContainer(
                              width: 150,
                              height: 30,
                              color: AppColors.red,
                              child: Center(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        label: 'Create new',
                                        size: 10,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(Icons.add,
                                          color: AppColors.white, size: 15),
                                    ]),
                              ),
                            ),
                          ),
                        ),
                        const Gap(20),
                        CustomAppBar(
                            text: 'Search via title',
                            controller: controller,
                            setSearchValue: (searchQuery) {
                              searchNotifier.value = searchQuery;
                            }),
                        const Gap(20),
                        Flexible(
                          flex: 2,
                          child: CustomContainer(
                            width: 47,
                            height: 30,
                            color: AppColors.red,
                            child: Center(
                              child: StreamBuilder<List<String>>(
                                stream: catagory,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CupertinoActivityIndicator();
                                  } else if (snapshot.hasData) {
                                    final categories =
                                        snapshot.data!.toSet().toList();

                                    return Consumer<DropDownProvider>(
                                      builder: (context, provider, _) {
                                        return DJDropDownWidget(
                                          itemList: categories,
                                          icon: Icons.filter_alt_outlined,
                                          controller: controller,
                                          onChanged: (String? selectedOption) {
                                            provider.setSelectedOption(
                                                selectedOption!);
                                          },
                                          dropdownItemTextStyle:
                                              const TextStyle(fontSize: 12),
                                        );
                                      },
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        const Gap(20),
                        InkWell(
                          onTap: () {
                            Provider.of<DropDownProvider>(context,
                                    listen: false)
                                .clearSelectedCategory();
                          },
                          child: const CustomContainer(
                            isBorder: true,
                            width: 60,
                            height: 30,
                            color: AppColors.red,
                            child: Center(
                              child: CustomText(
                                label: 'See All',
                                weight: FontWeight.w400,
                                color: AppColors.white,
                                size: 10,
                              ),
                            ),
                          ),
                        ),
                        const CustomSize(
                          width: 20,
                        ),
                        const CustomSize(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: AppColors.darkGrey,
                    indent: 20,
                    endIndent: 20,
                  ),
                  SizedBox(
                      height: height,
                      width: width,
                      child: StreamBuilder<List<EcommerceProductModel>>(
                        stream: fetchProducts,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return SizedBox(
                                width: width * 0.9,
                                child: const CupertinoActivityIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text('No products found here'));
                          } else {
                            return Consumer<DropDownProvider>(
                              builder: (context, provider, _) {
                                List<EcommerceProductModel> filteredProducts =
                                    provider.selectedOption.isEmpty
                                        ? snapshot.data!
                                        : snapshot.data!
                                            .where((element) => element
                                                .category!
                                                .toLowerCase()
                                                .contains(provider
                                                    .selectedOption
                                                    .toLowerCase()))
                                            .toList();

                                return ValueListenableBuilder(
                                  valueListenable: searchNotifier,
                                  builder: (context, query, child) {
                                    print("Query: $query");
                                    filteredProducts = query.isEmpty
                                        ? filteredProducts
                                        : filteredProducts
                                            .where((element) => element.title!
                                                .toLowerCase()
                                                .contains(query.toLowerCase()))
                                            .toList();
                                    print(
                                        "Filtered data length: ${filteredProducts.length}");
                                    print("Filtered data: $filteredProducts");

                                    if (filteredProducts.isNotEmpty) {
                                      return GridView.builder(
                                        itemCount: filteredProducts.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount:
                                                    width > 1200 ? 5 : 2,
                                                mainAxisExtent: mainAxisExtent,
                                                crossAxisSpacing: 20,
                                                mainAxisSpacing: 20),
                                        itemBuilder: (context, index) =>
                                            _productContainer(
                                          onEdit: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AddEcommerceProduct(
                                                  ecommerceProductModel:
                                                      filteredProducts[index],
                                                ),
                                              ),
                                            );
                                          },
                                          onDelete: () {
                                            ShowDeleteDialog.showDeleteDialog(
                                              context: context,
                                              deleteButton: () {
                                                log('..........productid....${filteredProducts[index].docId}');
                                                EcommerceServices.deleteProduct(
                                                  productId:
                                                      '${filteredProducts[index].docId}',
                                                  context: context,
                                                );
                                              },
                                            );
                                          },
                                          imagePath:
                                              '${filteredProducts[index].imageUrl}',
                                          title:
                                              '${filteredProducts[index].title}',
                                          price: filteredProducts[index].price,
                                        ),
                                      );
                                    } else {
                                      return const Text('');
                                    }
                                  },
                                );
                              },
                            );
                          }
                        },
                      ))
                ],
              )),
        ),
      ),
    );
  }

  Widget _productContainer({
    String? imagePath,
    String? title,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
    double? price,
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
                Row(
                  children: [
                    const CustomText(
                      label: 'title: ',
                      color: AppColors.black,
                    ),
                    CustomText(
                      label: '$title',
                      color: AppColors.black,
                    ),
                  ],
                ),
                const CustomSize(
                  height: 5,
                ),
                Row(
                  children: [
                    const CustomText(
                      label: 'Price: ',
                      color: AppColors.black,
                    ),
                    CustomText(
                      label: '$price',
                      color: AppColors.black,
                    ),
                  ],
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
