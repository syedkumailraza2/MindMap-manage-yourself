import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mindmap/Theme/theme.dart';
import 'package:mindmap/View/home.dart';
import 'package:mindmap/View/login.dart';
import 'package:mindmap/firebase_options.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        ),
        home: AuthGateway(),
      //home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthGateway extends StatelessWidget {
  const AuthGateway({super.key});

  @override
  Widget build(BuildContext context) {
    final GetStorage storage = GetStorage();
    final user = storage.read('user');

    // Using Future.microtask to navigate after the widget builds
    Future.microtask(() {
      if (user != null) {
        Get.offAll(() =>  Home());
      } else {
        Get.offAll(() => LoginScreen());
      }
    });

    // Temporary placeholder while deciding route
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(child: CircularProgressIndicator(color: AppColors.primary,)),
    );
  }
}