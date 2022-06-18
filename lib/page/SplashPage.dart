import 'package:pa_mobile_tani_shop/Controller/SplashScreenController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final SplashScreenController spc = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromARGB(239,152,247,175),      
      body: Center(
        child: Column (
          children: [
            SizedBox(
              height: 150 ,
            ),
            Image.asset(
              "assets/images/Tani.png",
              width: MediaQuery.of(context).size.width / 2 ,
              height: MediaQuery.of(context).size.height / 2 ,
            ),
            Text(
              "TANI SHOP",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Rubik',
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),  
      ),
    );
  }
}