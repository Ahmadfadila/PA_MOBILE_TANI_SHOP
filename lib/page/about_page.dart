import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
            appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Color.fromARGB(255, 46, 45, 45)),
        title: Text(
          "Tentang Aplikasi",
          style: TextStyle(
            fontFamily: "Quicksand",
            fontSize: 16,
            color: Color.fromARGB(255, 46, 45, 45),
            fontWeight: FontWeight.w600
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Image.asset(
                    "assets/images/unmul.png",
                    height: 100,
                    width: 100,
                  ),
                ),
                Image.asset(
                  "assets/images/Tani.png",
                  height: 100,
                  width: 100,
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "INFORMATIKA\nUNMUL",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 54, 60, 79),
                fontSize: 18,
                fontFamily: "Quicksand",
                fontWeight: FontWeight.w700
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Tani Shop",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 54, 60, 79),
                fontSize: 18,
                fontFamily: "Quicksand",
                fontWeight: FontWeight.w700
              ),
            ),
            Text(
              "Version 1.0.0",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 54, 60, 79),
                fontSize: 12,
                fontFamily: "Quicksand",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Dibuat oleh :",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 54, 60, 79),
                fontSize: 15,
                fontFamily: "Quicksand",
                fontWeight: FontWeight.w700
              ),
            ),
            Text(
              "Feriansyah (1915016071)\nAhmad Fadila (1915016078)\nM.Nur Ismianto (1915016096)\nRupi Mansini (1915016101)\nIrvan Fadillah Ramadhan (1915016109)",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 54, 60, 79),
                fontSize: 12,
                fontFamily: "Quicksand",
              ),
            ),
          ],
        ),
      )
    );
  }
}