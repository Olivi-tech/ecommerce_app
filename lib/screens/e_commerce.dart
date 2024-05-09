import 'package:e_commerece_admin_panel/constants/app_images.dart';
import 'package:e_commerece_admin_panel/constants/app_text.dart';
import 'package:e_commerece_admin_panel/firebase_services/ecommerece_services.dart';
import 'package:e_commerece_admin_panel/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import '../constants/app_colors.dart';
import '../models/ecommerce_product_model.dart';
import '../widgets/custom_container.dart';
import '../widgets/custom_display_image.dart';
import '../widgets/custom_input_field.dart';
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

class _EcommerceScreenState extends State<EcommerceScreen> {
  @override
  void initState() {
    fetchProducts = EcommerceServices.fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    print('the width is $width');
    double mainAxisExtent = width < 720 ? 210 : 200;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: CustomInputField(
                            height: 35,
                            controller: searchController,
                            labelText: 'Search',
                            suffixIcon: const Icon(Icons.search,
                                color: AppColors.darkGrey, size: 15),
                          ),
                        ),
                      ),
                    ),
                    const CustomSize(
                      width: 20,
                    ),
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
                    const CustomSize(
                      width: 20,
                    ),
                  ],
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
                          final products = snapshot.data;
                          return GridView.builder(
                            itemCount: products!.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    mainAxisExtent: mainAxisExtent,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            itemBuilder: (context, index) => Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: AppColors.darkGrey, width: 1)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20)),
                                      child: Image.network(
                                          height: height * 0.15,
                                          width: width * 0.3,
                                          fit: BoxFit.cover,
                                          products[index].imageUrl!)),
                                  const Gap(8),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      children: [
                                        const Flexible(
                                            child: CustomText(label: 'Name: ')),
                                        Flexible(
                                            child: CustomText(
                                          label: products[index].title!,
                                        )),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      children: [
                                        const Flexible(
                                          child: CustomText(
                                            label: 'price: ',
                                          ),
                                        ),
                                        Flexible(
                                            child: CustomText(
                                                label: products[index]
                                                    .price!
                                                    .toString())),
                                      ],
                                    ),
                                  ),
                                  const Gap(8),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddEcommerceProduct(
                                                          ecommerceProductModel:
                                                              products[index],
                                                        )),
                                              );
                                            },
                                            child: CustomContainer(
                                              height: 30,
                                              borderColor:
                                                  Colors.grey.withOpacity(0.3),
                                              color: AppColors.white,
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Icon(
                                                      Icons.edit,
                                                      color: AppColors.darkGrey,
                                                      size: 15,
                                                    ),
                                                  ),
                                                  CustomSize(
                                                    width: 5,
                                                  ),
                                                  Flexible(
                                                    child: CustomText(
                                                      label: 'Edit',
                                                      weight: FontWeight.w700,
                                                      size: 10,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Gap(5),
                                        Flexible(
                                          child: InkWell(
                                            onTap: () {},
                                            child: CustomContainer(
                                              height: 30,
                                              borderColor:
                                                  Colors.grey.withOpacity(0.3),
                                              color: AppColors.white,
                                              child: Center(
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Flexible(
                                                        child: InkWell(
                                                          onTap: () {
                                                            EcommerceServices
                                                                .deleteProduct(
                                                                    products[
                                                                            index]
                                                                        .docId!);
                                                          },
                                                          child: const Icon(
                                                              Icons.delete,
                                                              color: Colors.red,
                                                              size: 15),
                                                        ),
                                                      ),
                                                      const Flexible(
                                                        child: CustomText(
                                                          label: 'Delete',
                                                          size: 10,
                                                          color: Colors.red,
                                                        ),
                                                      )
                                                    ]),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      }),
                )
              ],
            )),
      ),
    );
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
