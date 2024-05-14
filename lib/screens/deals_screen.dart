import 'dart:developer';

import 'package:e_commerece_admin_panel/constants/app_colors.dart';
import 'package:e_commerece_admin_panel/constants/custom_appbar.dart';
import 'package:e_commerece_admin_panel/firebase_services/ecommerece_services.dart';
import 'package:e_commerece_admin_panel/models/deals_model.dart';
import 'package:e_commerece_admin_panel/providers/clear_All_provider.dart';
import 'package:e_commerece_admin_panel/providers/drop_down_provider.dart';
import 'package:e_commerece_admin_panel/providers/image_picker_provider.dart';
import 'package:e_commerece_admin_panel/screens/add_deals.dart';
import 'package:e_commerece_admin_panel/utils/show_delete_dialog.dart';
import 'package:e_commerece_admin_panel/widgets/custom_container.dart';
import 'package:e_commerece_admin_panel/widgets/custom_display_image.dart';
import 'package:e_commerece_admin_panel/widgets/custom_size.dart';
import 'package:e_commerece_admin_panel/widgets/custom_text.dart';
import 'package:e_commerece_admin_panel/widgets/drop_down_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class DealsScreen extends StatefulWidget {
  const DealsScreen({super.key});

  @override
  State<DealsScreen> createState() => _DealsScreenState();
}

TextEditingController searchController = TextEditingController();
late Stream<List<EcommerceDealsModel>> fetchDeals;
late ImagePickerProvider pickerProvider;
late EcommerceDealsModel? ecommerceDealsModel;
late SearchProvider searchProvider;
ValueNotifier<String> searchNotifier = ValueNotifier<String>('');
TextEditingController controller = TextEditingController();
List<EcommerceDealsModel> filterEventData = [];
List<EcommerceDealsModel> eventData = [];
ValueNotifier<String> selectedValueNotifier = ValueNotifier('All');
late Stream<List<String>> catagory = EcommerceServices.fetchCatagory();
late ImagePickerProvider imagePickerProvider;

class _DealsScreenState extends State<DealsScreen> {
  @override
  void initState() {
    imagePickerProvider =
        Provider.of<ImagePickerProvider>(context, listen: false);
    searchProvider = Provider.of<SearchProvider>(context, listen: false);
    fetchDeals = EcommerceServices.fetchDeals();
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
                                    builder: (context) => const CreateDeals(),
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
                      child: StreamBuilder<List<EcommerceDealsModel>>(
                        stream: fetchDeals,
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
                                child: Text('No deals available'));
                          } else {
                            return Consumer<DropDownProvider>(
                              builder: (context, provider, _) {
                                List<EcommerceDealsModel> filteredProducts =
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
                                                          CreateDeals(
                                                        ecommerceDealsModel:
                                                            filteredProducts[
                                                                index],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                onDelete: () {
                                                  ShowDeleteDialog
                                                      .showDeleteDialog(
                                                    context: context,
                                                    deleteButton: () {
                                                      log('..........productid....${filteredProducts[index].docId}');
                                                      EcommerceServices
                                                          .deleteDeals(
                                                        dealsId:
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
                                                price: filteredProducts[index]
                                                    .price,
                                                duration:
                                                    '${filteredProducts[index].duration}'),
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
    String? duration,
  }) {
    return CustomContainer(
      borderColor: Colors.grey.withOpacity(0.3),
      child: Expanded(
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
                        size: 12,
                        label: 'title: ',
                        color: AppColors.black,
                      ),
                      CustomText(
                        size: 12,
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
                        size: 12,
                        label: 'Price: ',
                        color: AppColors.black,
                      ),
                      CustomText(
                        size: 12,
                        label: '$price',
                        color: AppColors.black,
                      ),
                    ],
                  ),
                  const CustomSize(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const CustomText(
                        size: 12,
                        label: 'duration: ',
                        color: AppColors.black,
                      ),
                      CustomText(
                        size: 12,
                        label: '$duration',
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
      ),
    );
  }
}
