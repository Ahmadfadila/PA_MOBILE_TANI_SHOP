import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_mobile_tani_shop/Controller/user_controller.dart';
import 'package:pa_mobile_tani_shop/components/bottom_nav_bar_pembeli.dart';
import 'package:pa_mobile_tani_shop/components/bottom_nav_bar_penjual.dart';
import 'package:pa_mobile_tani_shop/page/Pembeli_page/Home_Pembeli.dart';
import 'package:pa_mobile_tani_shop/page/about_page.dart';
import 'package:pa_mobile_tani_shop/page/login.dart';
import 'package:pa_mobile_tani_shop/page/profile/edit_password.dart';
import 'package:pa_mobile_tani_shop/page/profile/edit_profile_page.dart';
import 'package:pa_mobile_tani_shop/services/authentication_service.dart';
import 'package:pa_mobile_tani_shop/services/user_services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

class ProfilePage extends StatelessWidget {

  var idDoc = UserServices.getUserIdDoc();
  
  final UserController userController = Get.find();

  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    await _picker.pickImage(source: ImageSource.gallery).then((value){
      if (value != null) {
        _photo = File(value.path);
        uploadFile(_photo);
      } else {
        Get.defaultDialog(
          middleText: "Tidak ada gambar yang dipillih"
        );
      }
    });
  }

  Future imgFromCamera() async {
    await _picker.pickImage(source: ImageSource.camera).then((value){
      if (value != null) {
        _photo = File(value.path);
        uploadFile(_photo);
      } else {
        Get.defaultDialog(
          middleText: "Tidak ada gambar yang dipillih"
        );
      }
    });
  }

  Future uploadFile(filePhoto) async {
    if (filePhoto == null) return;
    final fileName = basename(filePhoto!.path);
    final destination = 'files/profiles';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('$fileName');
      await ref.putFile(filePhoto!);
      
      String url = (await ref.getDownloadURL()).toString();

      UserServices.updatePictureProfile(url);
    } catch (e) {
      Get.defaultDialog(
        middleText: "Terjadi kesalahan"
      );
    }
  }

  void showPicker(context) {
    showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return SafeArea(
        child: Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: new Text('Gallery'),
                  onTap: () {
                    imgFromGallery();
                    Navigator.of(context).pop();
                  }),
              ListTile(
                leading: new Icon(Icons.photo_camera),
                title: new Text('Camera'),
                onTap: () {
                  imgFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    print(userController.User.value);
    return Scaffold(
      backgroundColor: Colors.white,
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child :Column(
              children: [
                IconButton(
                  onPressed: () {
                    AuthServices.signOut();
                    Get.off(() => LoginPage());
                  },
                  icon: Icon(
                    Icons.logout_rounded,
                    color: Colors.red,
                  ),
                ),
              ]
            ),
          )
        ],
        backgroundColor: Color.fromARGB(255,152,247,175),
        elevation: 0,
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
      body: SafeArea(
        child: FutureBuilder<String>(
          future: idDoc,
          builder: (_, AsyncSnapshot<String> _snapshot) {
            return (_snapshot.hasData)
              ? FutureBuilder<DocumentSnapshot>(
              future: users.doc(_snapshot.data.toString()).get(),
              builder: (_, snapshot) {
                return (snapshot.hasData)
                  ? Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 100,
                          color: Color.fromARGB(255,152,247,175),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: InkWell(
                                    onTap: () => showPicker(context),
                                    child: const Text(
                                      "Ubah Gambar",
                                      style: TextStyle(
                                        fontFamily: "Quicksand",
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blue
                                      ),  
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Container(
                                    height: 200,
                                    width: 250,
                                    decoration: BoxDecoration(
                                      color :Color.fromARGB(80, 152,247,175),
                                      borderRadius: BorderRadius.circular(50)
                                    ),  
                                    child:Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          "Nama",
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 54, 60, 79),
                                            fontFamily: "Quicksand",
                                            fontSize: 15,
                                            letterSpacing: 0.2,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Text(
                                          snapshot.data!.get("name"),
                                          style: const TextStyle(
                                            color: Color.fromARGB(255, 54, 60, 79),
                                            fontFamily: "Quicksand",
                                            fontSize: 15,
                                            letterSpacing: 0.8,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          "Email",
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 54, 60, 79),
                                            fontFamily: "Quicksand",
                                            fontSize: 15,
                                            letterSpacing: 0.2,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Text(
                                          snapshot.data!.get("email"),
                                          style: const TextStyle(
                                            color: Color.fromARGB(255, 54, 60, 79),
                                            fontFamily: "Quicksand",
                                            fontSize: 15,
                                            letterSpacing: 0.8,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          "No. Telp",
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 54, 60, 79),
                                            fontFamily: "Quicksand",
                                            fontSize: 15,
                                            letterSpacing: 0.2,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Text(
                                          snapshot.data!.get("notelp"),
                                          style: const TextStyle(
                                            color: Color.fromARGB(255, 54, 60, 79),
                                            fontFamily: "Quicksand",
                                            fontSize: 15,
                                            letterSpacing: 0.8,
                                          ),
                                        ),
                                        const SizedBox(height: 16,),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 20, right: 40),
                                              child: TextButton(
                                                onPressed: ()=> Get.to(() => EditProfile()), 
                                                child: Text(
                                                  "Ubah profil",
                                                  style: TextStyle(
                                                    fontFamily: "Quicksand",
                                                    fontWeight: FontWeight.w600
                                                  ),
                                                ),
                                                style: TextButton.styleFrom(
                                                  minimumSize: Size.zero,
                                                  padding: EdgeInsets.zero,
                                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () => Get.to(() => EditPass()), 
                                              child: Text(
                                                "Ubah password",
                                                style: TextStyle(
                                                  fontFamily: "Quicksand",
                                                  fontWeight: FontWeight.w600
                                                ),
                                              ),
                                              style: TextButton.styleFrom(
                                                minimumSize: Size.zero,
                                                padding: EdgeInsets.zero,
                                                tapTargetSize: MaterialTapTargetSize.shrinkWrap
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]
                                    )
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.33,
                      top: MediaQuery.of(context).size.height * 0.055,
                      child: CircleAvatar(
                        radius: 56,
                        backgroundColor: Color.fromARGB(255, 226, 225, 225),
                        child: Padding(
                          padding: EdgeInsets.all(2),
                          child: ClipOval(
                            child: snapshot.data!.get("image_url") != "" ? FadeInImage.assetNetwork(
                              placeholder: "assets/images/user.png", 
                              image: snapshot.data!.get("image_url") 
                              ): Image.asset("assets/images/user.png")
                            )),
                      ),
                    )
                  ],
                ): Text("Loading ...");
              },
            ):Text("Loading ..."); 
          },
        ) 
      ),
      bottomNavigationBar: userController.User.value == "Pembeli" ? BottomNavBar() : BottomNavBarPenjual(),
    );
  }
}