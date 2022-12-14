import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_firebase/app/controllers/auth_controller.dart';
import 'package:first_firebase/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<AuthController>();
  HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => authC.logout(),
              icon: const Icon(Icons.logout_rounded))
        ],
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
          stream: controller.getData(),
          builder: (context, snapshot) {
            final data = snapshot.data?.docs;

            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: data?.length,
                itemBuilder: (context, index) {
                  Map<String, String> dataUser = {
                    "id": "${data?[index].id}",
                    "dataName": "${data?[index]["name"]}",
                    "dataAge": "${data?[index]["age"]}",
                    "dataAddress": "${data?[index]["address"]}",
                  };
                  return ListTile(
                    onTap: () {
                      Get.toNamed(Routes.EDIT_DATA, parameters: dataUser);
                    },
                    title: Text(data?[index]["name"]),
                    subtitle: Text(
                        "${data?[index]["address"]} | ${data![index]["age"].toString()}"),
                    trailing: IconButton(
                        onPressed: () {
                          Get.defaultDialog(
                              middleText:
                                  "Apakah anda yakin ingin menghapus data ini?",
                              textCancel: "Cancel",
                              onCancel: () => Get.back(),
                              textConfirm: "Sure",
                              confirmTextColor: Colors.red,
                              onConfirm: () {
                                controller.deleteData(data[index].id);
                                Get.back();
                                Get.snackbar(
                                    'info', 'Data successfully deleted',
                                    backgroundColor: Colors.green,
                                    colorText: Colors.white);
                              });
                        },
                        icon: const Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                        )),
                  );
                });
          }),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(10),
        child: MaterialButton(
          height: 50,
          color: Colors.lightBlue,
          textColor: Colors.white,
          onPressed: () => Get.toNamed(Routes.ADD_DATA),
          child: const Text("Tambah Data"),
        ),
      ),
    );
  }
}
