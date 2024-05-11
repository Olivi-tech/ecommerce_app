import 'dart:developer';
import 'package:e_commerece_admin_panel/firebase_services/ecommerece_services.dart';
import 'package:e_commerece_admin_panel/providers/clear_All_provider.dart';
import 'package:e_commerece_admin_panel/providers/image_picker_provider.dart';
import 'package:e_commerece_admin_panel/utils/show_delete_dialog.dart';
import 'package:e_commerece_admin_panel/widgets/drop_down_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../constants/custom_appbar.dart';
import '../models/ecommerce_product_model.dart';
import '../widgets/custom_container.dart';
import '../widgets/custom_display_image.dart';
import '../widgets/custom_size.dart';
import '../widgets/custom_text.dart';
import 'add_ecommerece_product.dart';

class EcommerceScreen extends StatefulWidget {
  const EcommerceScreen({super.key});
  @override
  State<EcommerceScreen> createState() => _EcommerceScreenState();
}

TextEditingController searchController = TextEditingController();
late Stream<List<EcommerceProductModel>> fetchProducts;

late ImagePickerProvider pickerProvider;
late SearchProvider searchProvider;
ValueNotifier<String> searchNotifier = ValueNotifier<String>('');
TextEditingController controller = TextEditingController();
List<EcommerceProductModel> filterEventData = [];
List<EcommerceProductModel> eventData = [];

class _EcommerceScreenState extends State<EcommerceScreen> {
  @override
  void initState() {
    searchProvider = Provider.of<SearchProvider>(context, listen: false);
    fetchProducts = EcommerceServices.fetchProducts();
    pickerProvider = Provider.of<ImagePickerProvider>(context, listen: false);

    super.initState();
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
                              isBorder: true,
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
                            text: 'Search via catagory',
                            controller: controller,
                            setSearchValue: (searchQuery) {
                              searchNotifier.value = searchQuery;
                            }),
                        const Gap(20),
                        const Flexible(
                          flex: 4,
                          child: CustomContainer(
                            isBorder: true,
                            width: 150,
                            height: 30,
                            color: AppColors.red,
                            child: Center(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      label: 'Filter',
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(Icons.filter_alt_outlined,
                                        color: AppColors.white, size: 18),
                                  ]),
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
                          print("StreamBuilder rebuilt");

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
                            return ValueListenableBuilder(
                              valueListenable: searchNotifier,
                              builder: (context, query, child) {
                                print("Query: $query");
                                List<EcommerceProductModel> data = query.isEmpty
                                    ? snapshot.data!
                                    : snapshot.data!
                                        .where((element) => element.category!
                                            .toLowerCase()
                                            .contains(query.toLowerCase()))
                                        .toList();
                                print("Filtered data length: ${data.length}");
                                print("Snapshot data: $data");
                                print("Filtered data: $data");

                                if (data.isNotEmpty) {
                                  return GridView.builder(
                                      itemCount: data.length,
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
                                                              data[index],
                                                        )),
                                              );
                                            },
                                            onDelete: () {
                                              ShowDeleteDialog.showDeleteDialog(
                                                context: context,
                                                deleteButton: () {
                                                  log('..........productid....${data[index].docId}');
                                                  EcommerceServices
                                                      .deleteProduct(
                                                    productId:
                                                        '${data[index].docId}',
                                                    context: context,
                                                  );
                                                },
                                              );
                                            },
                                            imagePath:
                                                '${data[index].imageUrl}',
                                            title: '${data[index].title}',
                                            price: data[index].price,
                                          ));
                                } else {
                                  return Text('');
                                }
                              },
                            );
                          }
                        }),
                  )
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
                    CustomText(
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
