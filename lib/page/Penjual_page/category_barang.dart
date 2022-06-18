import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_mobile_tani_shop/Controller/barang_controller.dart';
import 'package:pa_mobile_tani_shop/page/Penjual_page/Home_Penjual.dart';
import 'package:pa_mobile_tani_shop/services/Barang_services.dart';

class CategoryBarang extends StatelessWidget {

  final CreateBarangTextController cetc = Get.find();
  final CreateBarangCategoryController rc = Get.put(CreateBarangCategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      color: Color.fromARGB(255, 54, 60, 79),
                      size: 22,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Tambah Barang",
                    style: TextStyle(
                      color: Color.fromARGB(255, 54, 60, 79),
                      fontSize: 22,
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 30),
              child: Text(
                "Pilih Kategori",
                style: TextStyle(
                  fontFamily: "Quicksand",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Flexible(
              child: ListTile(
                title: Text(
                  "Racun",
                  style: TextStyle(
                    fontFamily: "Quicksand",
                    fontSize: 14,
                  ),
                ),
                leading: Obx(
                  () => Radio<Delivery>(
                    value: Delivery.Racun,
                    groupValue:
                        rc.delivery.value, 
                    onChanged: (value) {
                      rc.delivery(value);
                    },
                  ),
                ),
              ),
            ),
            Flexible(
              child: ListTile(
                title: Text(
                  "Bibit",
                  style: TextStyle(
                    fontFamily: "Quicksand",
                    fontSize: 14,
                  ),
                ),
                leading: Obx(
                  () => Radio<Delivery>(
                      value: Delivery.Bibit,
                      groupValue: rc.delivery.value,
                      onChanged: (value) {
                        rc.delivery(value);
                      }),
                ),
              ),
            ),
            Flexible(
              child: ListTile(
                title: Text(
                  "Alat Pertanian",
                  style: TextStyle(
                    fontFamily: "Quicksand",
                    fontSize: 14,
                  ),
                ),
                leading: Obx(
                  () => Radio<Delivery>(
                      value: Delivery.Alat,
                      groupValue: rc.delivery.value,
                      onChanged: (value) {
                        rc.delivery(value);
                      }),
                ),
              ),
            ),
            Flexible(
              child: ListTile(
                title: Text(
                  "Others",
                  style: TextStyle(
                    fontFamily: "Quicksand",
                    fontSize: 14,
                  ),
                ),
                leading: Obx(
                  () => Radio<Delivery>(
                      value: Delivery.Others,
                      groupValue: rc.delivery.value,
                      onChanged: (value) {
                        rc.delivery(value);
                      }),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                width: 150,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async { 
                    rc.getDeliveryName();

                    if(cetc.idBarang.value == ""){
                      await BarangServices.addEvents()
                        .then((value) {
                          Get.off(() => PenjualHome());
                      });
                    }  else  {
                      await BarangServices.updateEvents()
                        .then((value) {
                          Get.off(() => PenjualHome());
                        });
                    }
                  },
                  child: Text(
                    'Simpan',
                    style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Quicksand",
                    fontSize: 14,
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
    );
  }
}