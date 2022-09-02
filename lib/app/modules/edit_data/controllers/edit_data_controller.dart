import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditDataController extends GetxController {
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

  Future<void> updateUser(String name, String address, int age,
      {String? docId}) async {
    DocumentReference docRef = firestore.collection("users").doc(docId);

    return await docRef
        .update({"name": name, "address": address, "age": age}).then((value) {
      log("data berhasil diupdate");
      nameC.clear();
      ageC.clear();
      addressC.clear();
      Get.snackbar('info', 'Data successfully update',
          backgroundColor: Colors.green, colorText: Colors.white);
    }).catchError((error) {
      log("$error");
      nameC.clear();
      ageC.clear();
      addressC.clear();
      Get.snackbar('info', '$error',
          backgroundColor: Colors.red, colorText: Colors.white);
    });
  }
}
