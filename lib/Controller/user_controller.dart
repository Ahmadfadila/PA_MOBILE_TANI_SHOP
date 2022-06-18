import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pa_mobile_tani_shop/services/Barang_services.dart';
import 'package:pa_mobile_tani_shop/services/user_barang_services.dart';
import 'package:pa_mobile_tani_shop/services/user_services.dart';

class UserController extends GetxController {
  final name = "".obs;
  final notelp = "".obs;
  final email = "".obs;
  final User = "".obs;
  final image_url = "".obs;
  final idUser = "".obs;
  final userBarang = [].obs;

  void pleaseFill() {
    UserServices.getUserData().then((data){
      name.value = data['name'];
      notelp.value = data['notelp']; 
      email.value = data['email'];
      User.value = data['user'];
      image_url.value = data['image_url'];
    });
  }

  void getId(){
    UserServices.getUserIdDoc().then((id) {
      idUser.value = id;
    });
  }


void getUserBarang() {
    UserBarangServices.getUserBarang().then((data){
      userBarang.value = data;
    });
  }
}

class GetTotal extends GetxController {
  final totalPrice = 0.obs;
  
  final UserController userController = Get.find();

  void getTotal() {
    userController.userBarang.forEach((element) {
      Barang.doc(element).get().then((v) => totalPrice.value += int.parse(v.get("price")));
    });
  }
}

class UserUpdateController extends GetxController {

  final UserController _userController = Get.find();

  final newNameController = TextEditingController();
  final newTelpController = TextEditingController();
  final newEmailController = TextEditingController();
  final passwordController = TextEditingController();

  onPressed() {
    UserServices.updateUser(
      newNameController.value.text, 
      newTelpController.value.text, 
      newEmailController.value.text,
      passwordController.value.text,
    );
  }

  @override
  void onReady() {
    newNameController.text = _userController.name.value;
    newTelpController.text = _userController.notelp.value;
    newEmailController.text = _userController.email.value;
    super.onReady();
  }
}