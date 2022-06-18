import 'dart:async';
import 'package:pa_mobile_tani_shop/page/LandingPage.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController{

  @override
  void onInit() {
    super.onInit();
    Timer(Duration(seconds: 3), () {
      Get.off(LandingPage());
    });
  }
}
