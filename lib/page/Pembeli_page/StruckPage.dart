import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_mobile_tani_shop/Controller/user_controller.dart';
import 'package:pa_mobile_tani_shop/page/Pembeli_page/Home_Pembeli.dart';
import 'package:pa_mobile_tani_shop/services/Barang_services.dart';


class StructPage extends StatelessWidget {

  final UserController userController = Get.find();
  final GetTotal getTotal = Get.put(GetTotal());
  
  @override
  Widget build(BuildContext context) {
    getTotal.getTotal();
    userController.getId();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 18,),
          children: [
          Container(
            margin: EdgeInsets.only(top: 15),
            padding: EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 0.75,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(50, 0, 0, 0),
                  offset: Offset(0, 6),
                  blurRadius: 5, 
                  spreadRadius: 0
                )
              ]
            ),
            child: Column(
              children : [
                Text("Struck Barang"),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: ListView(
                    children: userController.userBarang.value.map((e) => 
                    FutureBuilder<DocumentSnapshot>(
                      future: Barang.doc(e.toString()).get(),
                      builder: (_, snapshot) {
                        return (snapshot.hasData) ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            snapshot.data!.get("image_url") == "" ? 
                            Container(
                              margin: EdgeInsets.only(right: 5, bottom: 5),
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(5)
                              ),
                            ) : FadeInImage.assetNetwork(
                              placeholder: "assets/images/Tani.png", 
                              image: snapshot.data!.get("image_url"),
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data!.get("title"),
                                    style: TextStyle(
                                      height: 1.5,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                              Text(
                                snapshot.data!.get("category"),
                                style: TextStyle(
                                  height: 1.1,
                                  fontSize: 13
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          "Rp${snapshot.data!.get("price")}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ) : CircularProgressIndicator();
                      },
                    )
                  ).toList(),
                ),
              ),
              Divider(
                color: Color.fromARGB(100, 0, 0, 0),
                thickness: 0.1,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Obx(() => 
                  Text(
                  "Rp${(getTotal.totalPrice.value).toString()}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13
                    ),
                  ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                "Terima Kasih Sudah Belanja di Tani Shop",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Rubik',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                ),
              ),
              ],
            ), 
          ),
          ]
        )
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 30),
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: FloatingActionButton(
                onPressed: () async {
                  Get.off(MyHome());
                },
                backgroundColor: Color.fromARGB(255,152,247,175),
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.zero
                ),
                child: Text(
                  "Back To Home",
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 0,
                    fontFamily: "Quicksand",
                    fontSize: 15,
                    fontWeight: FontWeight.w600
                  ),
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}