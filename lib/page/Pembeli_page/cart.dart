import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_mobile_tani_shop/Controller/user_controller.dart';
import 'package:pa_mobile_tani_shop/components/bottom_nav_bar_pembeli.dart';
import 'package:pa_mobile_tani_shop/page/Pembeli_page/Home_Pembeli.dart';
import 'package:pa_mobile_tani_shop/page/Pembeli_page/StruckPage.dart';
import 'package:pa_mobile_tani_shop/page/about_page.dart';
import 'package:pa_mobile_tani_shop/services/Barang_services.dart';
import 'package:pa_mobile_tani_shop/services/user_barang_services.dart';

class Cart extends StatelessWidget {

  final UserController userController = Get.put(UserController());
  final GetTotal getTotal = Get.put(GetTotal());

  @override
  Widget build(BuildContext context) {
    getTotal.getTotal();
    userController.getId();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Color.fromARGB(255, 46, 45, 45)),
        title: const Text.rich(
          TextSpan(
            text: "TANI",
            style: const TextStyle(
              color: Color.fromARGB(255, 46, 45, 45),
              fontSize: 18,
              fontFamily: "Quicksand",
              fontWeight: FontWeight.w400
            ),
            children: [
              TextSpan(
                text: "SHOP",
                style: const TextStyle(
                  color: Color.fromARGB(255, 46, 45, 45),
                  fontSize: 18,
                  fontFamily: "Quicksand",
                  fontWeight: FontWeight.w700                
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255,152,247,175),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
              DrawerHeader(
                child: Column(
                  children: [
                    Text(
                      "Tani Shop",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Rubik',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Image.asset(
                          "assets/images/Tani.png",
                          scale: 2,
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255,2,62,74),
                ),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('Tentang Kami'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AboutPage()),
                ),
              )
          ],
        ),
      ),
      body: ListView(
        children: [
          SafeArea(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Keranjangmu",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
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
                                  IconButton(
                                    onPressed: (){
                                      UserBarangServices.deleteUserBarang(snapshot.data!.id);
                                      Get.off(() => MyHome());
                                    }, 
                                    icon: Icon(Icons.close))
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green
                            ),
                            onPressed: () {
                              UserBarang.where("id_user", isEqualTo: userController.idUser.value).get().then((value) => value.docs.forEach((element) { 
                                UserBarang.doc(element.id).delete().then((value) => Get.off(StructPage()));
                              }));
                              ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(16),
                                      height: 70,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(239, 152, 247, 175),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 60,
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Terima Kasih",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    fontSize: 12,
                                                    fontFamily: 'Poppins'),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                "Sudah Belanja",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    fontSize: 12,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontFamily: 'Poppins'),
                                              ),
                                            ],
                                          ))
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      left: 10,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                              ),
                            );
                            },
                            child: Text(
                              "Check Out Now",
                            ),
                          ),
                        )
                      ]
                    )
                  ),
                ],
              ),
            ),
          ),
        ]
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}