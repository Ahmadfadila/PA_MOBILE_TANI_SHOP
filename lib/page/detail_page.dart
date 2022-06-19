import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_mobile_tani_shop/Controller/user_controller.dart';
import 'package:pa_mobile_tani_shop/page/Pembeli_page/Home_Pembeli.dart';
import 'package:pa_mobile_tani_shop/page/Penjual_page/Home_Penjual.dart';
import 'package:pa_mobile_tani_shop/page/Penjual_page/edit_Barang_page.dart';
import 'package:pa_mobile_tani_shop/services/Barang_services.dart';
import 'package:pa_mobile_tani_shop/services/user_barang_services.dart';

class DetailPage extends StatelessWidget {

  String idBarang, price;

  DetailPage(this.idBarang, this.price,);

  final UserController userController = Get.find();
  bool isSigned = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Color.fromARGB(255, 46, 45, 45)),
        title: Text(
          "Detail Barang",
          style: TextStyle(
            fontFamily: "Quicksand",
            fontSize: 16,
            color: Color.fromARGB(255, 46, 45, 45)
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (userController.User.value == "Penjual") Container(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                elevation: 0,
                onPrimary: Colors.red,
              ),
              onPressed: () async {
                await Barang.doc(idBarang).delete().then((value) => Get.off(() => PenjualHome()));
              }, 
              child: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<DocumentSnapshot>(
          future: Barang.doc(idBarang).get(),
          builder: (_, snapshot) {
            return (snapshot.hasData)
              ? ListView(
              padding: EdgeInsets.symmetric(horizontal: 18,),
              children: [
              Container(
                  color: Color.fromARGB(255, 226, 225, 225),
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Center(
                        child: snapshot.data!.get('image_url') == "" ? Image.asset(
                          "assets/images/Tani.png",
                          width: 150,
                          height: 150,
                          alignment: Alignment.center,
                        ) : FadeInImage.assetNetwork(
                        placeholder: "assets/images/Tani.png", 
                        image: snapshot.data!.get('image_url'),
                        width: 250,
                        height: 200,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Column(
                  children: [
                    Text(
                      snapshot.data!.get("title"),
                      style: TextStyle(
                        fontSize: 22,
                        color: Color.fromARGB(255, 54, 60, 79),
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "By ${snapshot.data!.get('Penjual')}",
                      style: TextStyle(
                        color: Color.fromARGB(255, 54, 60, 79),
                        fontFamily: "Quicksand",
                        fontSize: 12
                      ),
                    ),
                  ],
                ),
                Text(
                  "Deskripsi Barang",
                  style: TextStyle(
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.w700,
                    fontSize: 12
                  )
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  snapshot.data!.get('deskripsi'),
                  style: TextStyle(
                    fontFamily: "Quicksand",
                    fontSize: 12
                  )
                ),
              ],
            ) : Text("Mengambil data ..."); 
          },
        ), 
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 30),
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Total Price\n",
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: "Quicksand",
                          color: Color.fromARGB(255, 54, 60, 79),
                          fontWeight: FontWeight.w700
                        ),
                      ),
                      TextSpan(
                        text: "Rp $price",
                        style: TextStyle(
                          height: 1.5,
                          fontFamily: "Quicksand",
                          color: Color.fromARGB(255, 54, 60, 79),
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ]
                  )
                ),            
              )
            ),
            Expanded(
              child: FloatingActionButton(
                onPressed: () async {
                  if(userController.User.value == "Penjual"){
                    Get.to(() => EditBarang(idBarang));
                  } else {
                    var dataBarang = await UserBarangServices.getUserBarang();
                    UserBarangServices.addUserBarang(idBarang).then((value) {
                      Get.back();
                    });
                  }
                },
                backgroundColor: Color.fromARGB(255,152,247,175),
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.zero
                ),
                child: Text(
                  userController.User.value == "Penjual" ? "Edit" : isSigned ? "Batalkan" : "Add To Cart",
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