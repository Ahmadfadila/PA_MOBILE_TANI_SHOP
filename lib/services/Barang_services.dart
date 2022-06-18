import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pa_mobile_tani_shop/Controller/barang_controller.dart';
import 'package:pa_mobile_tani_shop/Controller/user_controller.dart';
import 'package:pa_mobile_tani_shop/services/user_services.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference Barang = firestore.collection("barang");

class BarangServices {
  static Future addEvents() async {
    final CreateBarangTextController createBarangTextController = Get.find();
    final CheckBoxControllerbarang checkBoxController = Get.find();
    final CreateBarangCategoryController createBarangCategoryController = Get.find();
    final UserController userController = Get.find();

    final userId = await UserServices.getUserIdDoc().then((value) => value);

    await Barang.add({
      "idBarang": userId,
      "Penjual": userController.name.value,
      "title": createBarangTextController.barangName.value,
      "price": createBarangTextController.harga.value,
      "deskripsi": createBarangTextController.deskripsi.value,
      "isPublish": checkBoxController.isPublish.value,
      "category": createBarangCategoryController.deliveryName.value,
      "image_url": createBarangTextController.image_url.value,
      
    }).then((value) {
      Get.delete<CheckBoxControllerbarang>();
      Get.delete<CreateBarangTextController>();
    });

  }
  static Future updateEvents() async {
    final CreateBarangTextController createEventTextController = Get.find();
    final CheckBoxControllerbarang checkBoxController = Get.find();
    final CreateBarangCategoryController createEventCategoryController = Get.find();

    await Barang.doc(createEventTextController.idBarang.value).update({
      "title": createEventTextController.barangName.value,
      "price": createEventTextController.harga.value,
      "deskripsi": createEventTextController.deskripsi.value,
      "isPublish": checkBoxController.isPublish.value,
      "category": createEventCategoryController.deliveryName.value,
    }).then((value) {
      Get.delete<CheckBoxControllerbarang>();
      Get.delete<CreateBarangTextController>();
    });

  }

  static Future updatePicture(String url_image) async {

    final CreateBarangTextController createEventTextController = Get.find();

    Barang.doc(createEventTextController.idBarang.value).update({
      "image_url": url_image
    });
  }
}