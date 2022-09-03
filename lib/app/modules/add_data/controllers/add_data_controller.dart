import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddDataController extends GetxController {
  TextEditingController nameC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  TextEditingController ageC = TextEditingController();

  @override
  void onClose() {
    nameC.dispose();
    addressC.dispose();
    ageC.dispose();
    super.onClose();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addData(String name, String address, int age) async {
    CollectionReference users = firestore.collection("users");
    String dateNow = DateTime.now().toIso8601String();
    return await users.add({
      "name": name,
      "address": address,
      "age": age,
      "time": dateNow
    }).then((value) {
      log("user added");
      nameC.clear();
      ageC.clear();
      addressC.clear();
      Get.back();
      Get.snackbar('info', 'Data successfully added',
          backgroundColor: Colors.green, colorText: Colors.white);
    }).catchError((error) {
      log("error occured when adding data");
      Get.snackbar('info', '$error',
          backgroundColor: Colors.red, colorText: Colors.white);
    });
  }
}
