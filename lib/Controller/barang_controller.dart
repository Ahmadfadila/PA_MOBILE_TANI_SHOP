import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class BarangChose extends GetxController {
  var barangChosed = "".obs;
  var title = "".obs;

  void choseBarang(v){
    barangChosed.value = v;
  }

  void searchBarang(barangTitle){
    title.value = barangTitle;
  }

  @override
  void onReady() {
    barangChosed.value = "Semua";
    super.onReady();
  }
}

enum Delivery { Racun, Bibit, Alat, Others}

class CreateBarangCategoryController extends GetxController {
  var delivery = Delivery.Racun.obs;
  var deliveryName = "".obs;

  void getDeliveryName() {
    if (delivery == Delivery.Racun){
      deliveryName.value = "Racun";
    } else if (delivery == Delivery.Bibit){
      deliveryName.value = "Bibit";
    } else if (delivery == Delivery.Alat){
      deliveryName.value = "Alat";
    } else {
      deliveryName.value = "Others";
    }
  }

  onChanged (value) {
    delivery(value);
  }
}

class CheckBoxControllerbarang extends GetxController {
  var isPublish = false.obs;
  setValue(newValue) => isPublish(newValue!);
}

class CreateBarangTextController extends GetxController {
  var idBarang = "".obs;
  var barangName = "".obs;
  var harga = "".obs;
  var deskripsi = "".obs;
  var image_url = "".obs;

  final barangNameController = TextEditingController();
  final hargaController = TextEditingController();
  final deskripsiController = TextEditingController();

  void onPressed() {
    barangName.value = barangNameController.text;
    harga.value = hargaController.text;
    deskripsi.value = deskripsiController.text;
  }
}