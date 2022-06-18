import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:pa_mobile_tani_shop/Controller/barang_controller.dart';
import 'package:pa_mobile_tani_shop/page/Penjual_page/category_barang.dart';
import 'package:pa_mobile_tani_shop/services/Barang_services.dart';
import 'package:path/path.dart' as Path;

class EditBarang extends StatefulWidget {
  final String idBarang;
  const EditBarang (this.idBarang);

  @override
  State<EditBarang> createState() => _EditBarangState();
}

class _EditBarangState extends State<EditBarang> {

  final CheckBoxControllerbarang b = Get.put(CheckBoxControllerbarang());
  final CreateBarangTextController _textController = Get.put(CreateBarangTextController());

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
    final fileName = Path.basename(filePhoto!.path);
    final destination = 'files/profiles';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('$fileName');
      await ref.putFile(filePhoto!);
      
      String url = (await ref.getDownloadURL()).toString();

      BarangServices.updatePicture(url);
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
    _textController.idBarang.value = widget.idBarang;
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Color.fromARGB(255,152,247,175),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16, left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => Get.back(),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black,
                    size: 22,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Update Barang",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Container(
                  height: MediaQuery.of(context).size.height * 1.3,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
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
                          SizedBox(height: 10,),
                          Container(
                            margin: const EdgeInsets.only( left: 20, right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: TextField(
                                controller: _textController.barangNameController,
                                maxLines: 1,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.emailAddress,
                                obscureText: false,
                                decoration: InputDecoration(
                                    labelText: "Nama Barang",
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: "Quicksand",
                                      fontWeight: FontWeight.w300),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    suffixIcon: const SizedBox(),
                                ),
                              ),
                            )
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: TextField(
                                controller: _textController.hargaController,
                                maxLines: 1,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: "Harga",
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: "Quicksand",
                                    fontWeight: FontWeight.w300),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  suffixIcon: const SizedBox(),
                                ),
                              ),
                            )
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: TextFormField(
                                controller: _textController.deskripsiController,
                                maxLines: 5,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.text,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: "Deskripsi",
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: "Quicksand",
                                    fontWeight: FontWeight.w300),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  suffixIcon: const SizedBox(),
                                ),
                              ),
                            )
                          ),
                          ListTile(
                            title: Align(
                              alignment: Alignment(-1.25, 0),
                              child: Text(
                                "Publish",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Quicksand",
                                ),
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                            leading: Obx(
                              ()=> Checkbox(
                                value: b.isPublish.value, 
                                onChanged: (newValue) => b.setValue(newValue),
                              )
                            ),
                          ),
                           SizedBox(
                              height: 20 ,
                          ),
                          Center(
                            child: Container(
                              width: 150,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  _textController.onPressed();
                                  Get.to(() => CategoryBarang());
                                },
                                child: Text(
                                  'Selanjutnya',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Quicksand",
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: StadiumBorder(),
                                  primary: Color.fromARGB(255,152,247,175),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                ),
            ),
          ),
        ],
      )
      ),
    );
  }
}
