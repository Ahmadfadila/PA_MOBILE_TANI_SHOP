import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pa_mobile_tani_shop/Controller/user_controller.dart';
import 'package:pa_mobile_tani_shop/components/bottom_nav_bar_penjual.dart';
import 'package:flutter/Material.dart';
import 'package:pa_mobile_tani_shop/page/Penjual_page/add_barang.dart';
import 'package:pa_mobile_tani_shop/page/about_page.dart';
import 'package:pa_mobile_tani_shop/page/detail_page.dart';
import 'package:pa_mobile_tani_shop/services/Barang_services.dart';


class PenjualHome extends StatelessWidget {
  PenjualHome({Key? key}) : super(key: key);

  final UserController userController = Get.put(UserController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    userController.pleaseFill();
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
        elevation: 0,
      ),
      extendBodyBehindAppBar:true,
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
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(18, 0, 18, 60),
          children: [
            Text(
              "Barang Jualan",
              style: TextStyle(
                fontFamily: "Quicksand",
                fontWeight: FontWeight.w700,
                fontSize: 22
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Obx(() =>
              StreamBuilder<QuerySnapshot>(
                stream: Barang.where('idBarang', isEqualTo: userController.idUser.value).snapshots(),
                builder: (_, snapshot) {
                  return (snapshot.hasData) 
                    ? ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot doc = snapshot.data!.docs[index];
                        return GestureDetector(
                          onTap: () => Get.to(() => DetailPage(doc.id, doc['price'])),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: Color.fromARGB(255, 226, 225, 225),
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                child: Stack(
                                  children: [
                                    Center(
                                      child: doc['image_url'] == "" ? Image.asset(
                                        "assets/images/Tani.png",
                                        width: 150,
                                        height: 150,
                                        alignment: Alignment.center,
                                      ) : FadeInImage.assetNetwork(
                                      placeholder: "assets/images/Tani.png", 
                                      image: doc['image_url'],
                                      width: 250,
                                      height: 200,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                doc['title'],
                                style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              )
                            ],
                          ),
                        );
                      },
                    ) : Text ("Mengambil data...");
                }
              ), 
            ),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color.fromARGB(239,152,247,175),
        label: Row(
          children: [
            Icon(
              Icons.add,
              color: Colors.black,
              size: 20,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Tambah Barang",
              style: TextStyle(
                letterSpacing: 0,
                fontFamily: "Quicksand",
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w600
              ),
            )
          ],
        ),
        onPressed: () => Get.to(() => AddEvent()),
      ),
      bottomNavigationBar: BottomNavBarPenjual(),
    );
  }
}

