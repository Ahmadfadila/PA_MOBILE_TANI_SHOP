import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pa_mobile_tani_shop/Controller/barang_controller.dart';
import 'package:pa_mobile_tani_shop/Controller/user_controller.dart';
import 'package:flutter/Material.dart';
import 'package:pa_mobile_tani_shop/components/bottom_nav_bar_pembeli.dart';
import 'package:pa_mobile_tani_shop/page/about_page.dart';
import 'package:pa_mobile_tani_shop/page/detail_page.dart';
import 'package:pa_mobile_tani_shop/services/Barang_services.dart';

class MyHome extends StatelessWidget {
  MyHome({Key? key}) : super(key: key);

  final UserController userController = Get.put(UserController(), permanent: true);
  final BarangChose barangChose = Get.put(BarangChose());

  @override
  Widget build(BuildContext context) {
    userController.pleaseFill();
    userController.getUserBarang();
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
              )
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 18),
          children: [
            Text(
              "Temukan Kebutuhan Bertanimu !",
              style: TextStyle(
                fontFamily: "Quicksand",
                fontWeight: FontWeight.w700,
                fontSize: 22
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 40,
              child: TextField(
                onChanged: (value) => barangChose.searchBarang(value),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  prefixIcon: Icon(Icons.search_outlined),
                  hintText: "Cari Kebutuhanmu disini ...",
                  hintStyle: TextStyle(
                    fontFamily: "Quicksand",
                    fontSize: 15
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.grey
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Obx(
              () => Container(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      barangChose.choseBarang("Semua");
                    }, 
                    child: Row(
                      children: [
                        Icon(
                          Icons.explore_outlined,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Semua",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Quicksand",
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: barangChose.barangChosed.value == "Semua" ? Color.fromARGB(255,152,247,175) : Color.fromARGB(100,152,247,175),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)
                      )
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      barangChose.choseBarang("Racun");
                    }, 
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Racun",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Quicksand",
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: barangChose.barangChosed.value == "Racun" ? Color.fromARGB(255,152,247,175) : Color.fromARGB(100,152,247,175),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)
                      )
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      barangChose.choseBarang("Bibit");
                    }, 
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Bibit",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Quicksand",
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: barangChose.barangChosed.value == "Bibit" ? Color.fromARGB(255,152,247,175) : Color.fromARGB(100,152,247,175),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)
                      )
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      barangChose.choseBarang("Alat");
                    }, 
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Alat",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Quicksand",
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: barangChose.barangChosed.value == "Alat" ? Color.fromARGB(255,152,247,175) : Color.fromARGB(100,152,247,175),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)
                      )
                    ),
                  ),
                ],
              ),
            ),
            ),
            SizedBox(
              height: 20,
            ),
            Obx(
              () => StreamBuilder<QuerySnapshot>(
              stream: barangChose.barangChosed.value == "Semua" 
                ? barangChose.title.value == "" 
                ? Barang.where('isPublish', isEqualTo: true).snapshots() 
                : Barang.where('title', isNotEqualTo: barangChose.title.value + " ").orderBy("title")
                .startAt([barangChose.title.value,]).endAt([barangChose.title.value+'\uf8ff',]).snapshots() 
                : Barang.where('category', isEqualTo: barangChose.barangChosed.value).snapshots(),
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
                  ) : Text ("Mengambil data ....");
              }
            ), 
            ),
          ],
        )
      ),
      bottomNavigationBar: BottomNavBar(),   
    );
  }
}

