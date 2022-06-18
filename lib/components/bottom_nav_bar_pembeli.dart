import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_mobile_tani_shop/Controller/bottom_navbar_controller.dart';
import 'package:pa_mobile_tani_shop/page/Pembeli_page/Home_Pembeli.dart';
import 'package:pa_mobile_tani_shop/page/Pembeli_page/cart.dart';
import 'package:pa_mobile_tani_shop/page/profile/profile_page.dart';

class BottomNavBar extends StatelessWidget {
  
  final BottomNavbarController bottomNavbarController = Get.put(BottomNavbarController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35),
      height: 75,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color.fromARGB(239,152,247,175),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(80),
            topRight: Radius.circular(80),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -7),
              blurRadius: 33,
              color: Color(0xFF6DAED9).withOpacity(0.11),
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: IconButton(
              onPressed: () {
                bottomNavbarController.changePageIndex(2);
                Get.off(Cart());
              },
              icon: Obx(() => Icon(
                Icons.shopping_bag,
                color: bottomNavbarController.pageIndex.value == 2 ? Colors.green : Colors.black,
              )),
            ),
          ),
          SizedBox(
            height: 40,
            width: 40,
            child: IconButton(
              onPressed: () {
                bottomNavbarController.changePageIndex(0);
                Get.off(MyHome());
              },
              icon: Obx(() => Icon(
                Icons.home,
                color: bottomNavbarController.pageIndex.value == 0 ? Colors.green : Colors.black,
              )),
            ),
          ),
          SizedBox(
            height: 40,
            width: 40,
            child: IconButton(
              onPressed: () {
                bottomNavbarController.changePageIndex(1);
                Get.off(ProfilePage());
              },
              icon: Obx(() => Icon(
                Icons.person,
                color: bottomNavbarController.pageIndex.value == 1 ? Colors.green : Colors.black,
              )), 
            ),
          ),
        ],
      ),
    );
  }
}
