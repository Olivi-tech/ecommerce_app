import 'package:e_commerece_admin_panel/constants/app_colors.dart';
import 'package:e_commerece_admin_panel/constants/app_images.dart';
import 'package:e_commerece_admin_panel/firebase_services/ecommerece_services.dart';
import 'package:e_commerece_admin_panel/models/off_model.dart';
import 'package:e_commerece_admin_panel/providers/routing_provider.dart';
import 'package:e_commerece_admin_panel/screens/e_commerce.dart';
import 'package:e_commerece_admin_panel/utils/utils.dart';
import 'package:e_commerece_admin_panel/widgets/custom_button.dart';
import 'package:e_commerece_admin_panel/widgets/custom_input_field.dart';
import 'package:e_commerece_admin_panel/widgets/custom_size.dart';
import 'package:e_commerece_admin_panel/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddOff extends StatefulWidget {
  const AddOff({super.key});

  @override
  State<AddOff> createState() => _AddOffState();
}

final TextEditingController _seasonController = TextEditingController();
final TextEditingController _offController = TextEditingController();
ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);
late RoutingProvider routingProvider;

class _AddOffState extends State<AddOff> {
  @override
  void initState() {
    routingProvider = Provider.of<RoutingProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 30),
      child: Column(
        children: [
          Container(
            height: height * 0.8,
            width: width * 0.8,
            decoration: BoxDecoration(
                color: AppColors.greyColor,
                borderRadius: BorderRadius.circular(32)),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32)),
                  child: Image.asset(
                    fit: BoxFit.cover,
                    AppImages.offImage,
                    width: width * 0.9,
                    height: height * 0.5,
                  ),
                ),
                const CustomSize(
                  height: 20,
                ),
                SizedBox(
                  width: width * 0.6,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                                label: 'Season',
                                size: 12,
                                weight: FontWeight.w400),
                            const CustomSize(
                              height: 5,
                            ),
                            CustomInputField(
                              maxLine: 1,
                              controller: _seasonController,
                              labelText: 'Season',
                            ),
                          ],
                        ),
                      ),
                      const CustomSize(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                                label: 'Overall off ',
                                size: 12,
                                weight: FontWeight.w400),
                            const CustomSize(
                              height: 5,
                            ),
                            CustomInputField(
                              maxLine: 1,
                              controller: _offController,
                              labelText: 'Overall off',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const CustomSize(
                  height: 15,
                ),
                ValueListenableBuilder(
                    valueListenable: isLoadingNotifier,
                    builder: (context, isLoading, child) => Center(
                          child: SizedBox(
                            width: width * 0.2,
                            height: height * 0.07,
                            child: CustomButton(
                                text: 'Add',
                                width: 150,
                                isLoading: isLoading,
                                color: AppColors.red,
                                textColor: AppColors.white,
                                onPressed: () async {
                                  isLoadingNotifier.value = true;

                                  String docId = AppUtils.getUniqueID();
                                  OffModel offModel = OffModel(
                                    season: _seasonController.text,
                                    off: _offController.text,
                                    docId: docId,
                                  );
                                  EcommerceServices.uploadOff(
                                          offModel: offModel, docId: docId)
                                      .then((value) {
                                    isLoadingNotifier.value = false;

                                    AppUtils.toastMessage(
                                        'Off created successfully');
                                    routingProvider.setindex(1);
                                    const EcommerceScreen();
                                    _seasonController.clear();
                                    _offController.clear();
                                  });
                                }),
                          ),
                        ))
              ],
            ),
          )
        ],
      ),
    ));
  }
}
