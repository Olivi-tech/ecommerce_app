import 'package:e_commerece_admin_panel/firebase_options.dart';
import 'package:e_commerece_admin_panel/providers/clear_All_provider.dart';
import 'package:e_commerece_admin_panel/providers/drop_down_provider.dart';
import 'package:e_commerece_admin_panel/providers/product_model_provide.dart';
import 'package:e_commerece_admin_panel/providers/edit_image_provider.dart';
import 'package:e_commerece_admin_panel/providers/image_picker_provider.dart';
import 'package:e_commerece_admin_panel/providers/routing_provider.dart';
import 'package:e_commerece_admin_panel/providers/screen_transition_provider.dart';
import 'package:e_commerece_admin_panel/screens/sign_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/file_name_picker_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RoutingProvider>(
          create: (context) => RoutingProvider(),
        ),
        ChangeNotifierProvider<DropDownProvider>(
          create: (context) => DropDownProvider(),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (context) => SearchProvider(),
        ),
        ChangeNotifierProvider<EditImagePickerProvider>(
          create: (context) => EditImagePickerProvider(),
        ),
        ChangeNotifierProvider<ProductModelProvider>(
          create: (context) => ProductModelProvider(),
        ),
        ChangeNotifierProvider<FileNamePickerProvider>(
          create: (context) => FileNamePickerProvider(),
        ),
        ChangeNotifierProvider<ImagePickerProvider>(
          create: (context) => ImagePickerProvider(),
        ),
        ChangeNotifierProvider<ScreenTransitionProvider>(
          create: (context) => ScreenTransitionProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SignInScreen(),
      ),
    );
  }
}
