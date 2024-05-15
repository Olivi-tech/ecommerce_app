import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_images.dart';
import '../providers/screen_transition_provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late ScreenTransitionProvider screenTransitionProvider;
  @override
  void initState() {
    super.initState();
    screenTransitionProvider =
        Provider.of<ScreenTransitionProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    return Consumer<ScreenTransitionProvider>(
        builder: (context, providerIndex, child) {
      return Container(
        height: height,
        width: 240,
        decoration: const BoxDecoration(
            color: AppColors.white,
            border: Border(right: BorderSide(color: AppColors.red))),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 20, 5, 2),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    height: 130,
                    width: 130,
                    child: Image.asset(
                      AppImages.logo,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.04),
                const Divider(
                  height: 8,
                  thickness: 1,
                  indent: 2,
                  endIndent: 2,
                ),
                SizedBox(height: height * 0.04),
                InkWell(
                  onTap: () {
                    screenTransitionProvider.setIndex = 0;
                  },
                  child: buildCustomContainer(
                    iconPath: AppImages.ecommerce,
                    height: height * 0.07,
                    iconColor: providerIndex.getIndex == 0
                        ? AppColors.white
                        : AppColors.darkGrey,
                    bgColor: providerIndex.getIndex == 0
                        ? AppColors.red
                        : AppColors.white,
                    textColor: providerIndex.getIndex == 0
                        ? AppColors.white
                        : AppColors.darkGrey,
                    text: 'Ecommerce',
                  ),
                ),
                SizedBox(height: height * 0.015),
                InkWell(
                  onTap: () {
                    screenTransitionProvider.setIndex = 1;
                  },
                  child: buildCustomContainer(
                    iconPath: AppImages.deals,
                    height: height * 0.07,
                    iconColor: providerIndex.getIndex == 1
                        ? AppColors.white
                        : AppColors.darkGrey,
                    bgColor: providerIndex.getIndex == 1
                        ? AppColors.red
                        : AppColors.white,
                    textColor: providerIndex.getIndex == 1
                        ? AppColors.white
                        : AppColors.darkGrey,
                    text: 'Deals',
                  ),
                ),
                SizedBox(height: height * 0.015),
                InkWell(
                  onTap: () {
                    screenTransitionProvider.setIndex = 2;
                  },
                  child: buildCustomContainer(
                    iconPath: AppImages.seasonOff,
                    height: height * 0.07,
                    iconColor: providerIndex.getIndex == 2
                        ? AppColors.white
                        : AppColors.darkGrey,
                    bgColor: providerIndex.getIndex == 2
                        ? AppColors.red
                        : AppColors.white,
                    textColor: providerIndex.getIndex == 2
                        ? AppColors.white
                        : AppColors.darkGrey,
                    text: 'Overall Off',
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget buildCustomContainer({
    required double height,
    Color? bgColor,
    required String iconPath,
    required Color iconColor,
    required String text,
    required Color textColor,
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: bgColor,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 3.0),
            child: SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
