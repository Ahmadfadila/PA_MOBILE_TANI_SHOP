import 'package:firebase_core/firebase_core.dart';
import 'package:pa_mobile_tani_shop/page/SplashPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tani Shop',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

