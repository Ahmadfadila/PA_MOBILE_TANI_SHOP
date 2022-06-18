import 'package:get/get.dart';

class BottomNavbarController extends GetxController {
  var pageIndex = 0.obs;

  void changePageIndex(int index) {
    pageIndex.value = index;
  }
}