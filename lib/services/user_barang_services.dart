import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pa_mobile_tani_shop/services/user_services.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference UserBarang = firestore.collection("UserBarang");

class UserBarangServices {
  static Future addUserBarang(String idBarang) async {

    final userId = await UserServices.getUserIdDoc().then((value) => value);

    UserBarang.add({
      "id_user": userId,
      "id_barang": idBarang,
    });

  }

  static Future getUserBarang() async {
    
    final userId = await UserServices.getUserIdDoc().then((value) => value);
    
    var dataBarang = [];

    await UserBarang.where('id_user', isEqualTo: userId).get().then((value){
      value.docs.forEach((element) { 
        dataBarang.add(element.get('id_barang'));
      });
    });

    return dataBarang;
  }

  static deleteUserBarang(idBarang) async {

    final userId = await UserServices.getUserIdDoc().then((value) => value);

    UserBarang.where('id_user', isEqualTo: userId).where('id_barang', isEqualTo: idBarang ).get()
    .then((value) => UserBarang.doc(value.docs[0].id).delete());    
  }

  

}
