import 'package:e_commerece_admin_panel/constants/app_images.dart';

import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import '../constants/app_colors.dart';
import '../widgets/custom_container.dart';
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

class _EcommerceScreenState extends State<EcommerceScreen> {
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
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisExtent: mainAxisExtent,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                    itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(color: AppColors.darkGrey, width: 1)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              child: Image.asset(
                                  height: height * 0.15,
                                  width: width * 0.3,
                                  fit: BoxFit.cover,
                                  AppImages.btsBoy)),
                          const Gap(8),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Flexible(child: CustomText(label: 'Name: ')),
                                Flexible(child: CustomText(label: 'Huma')),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Flexible(
                                  child: CustomText(
                                    label: 'price: ',
                                  ),
                                ),
                                Flexible(child: CustomText(label: '200')),
                              ],
                            ),
                          ),
                          const Gap(8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: InkWell(
                                    // onTap: onEdit,
                                    child: CustomContainer(
                                      height: 30,
                                      borderColor: Colors.grey.withOpacity(0.3),
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
                                    // onTap: onDelete,
                                    child: CustomContainer(
                                      height: 30,
                                      borderColor: Colors.grey.withOpacity(0.3),
                                      color: AppColors.white,
                                      child: const Center(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                child: Icon(Icons.delete,
                                                    color: Colors.red,
                                                    size: 15),
                                              ),
                                              Flexible(
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
                  ),
                )
              ],
            )),
      ),
    );
  }
}
