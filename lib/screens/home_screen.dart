import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../providers/screen_transition_provider.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/custom_text.dart';
import 'e_commerce.dart';
import 'setting-screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDrawerVisible = true;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    if (width < 830) {
      isDrawerVisible = false;
    } else {
      isDrawerVisible = true;
    }
    return Scaffold(
      key: _globalKey,
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.red,
        leading: IconButton(
            onPressed: () {
              _globalKey.currentState!.openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: AppColors.white,
            )),
        title: const CustomText(
          label: 'Dashboard',
          color: AppColors.white,
        ),
      ),
      body: Row(
        children: [
          Visibility(
            visible: isDrawerVisible,
            child: const CustomDrawer(),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Consumer<ScreenTransitionProvider>(
                  builder: (context, providerIndex, child) {
                return providerIndex.getIndex == 0
                    ? const EcommerceScreen()
                    : const SettingScreen();
              }),
            ),
          ),
        ],
      ),
    );
  }
}
