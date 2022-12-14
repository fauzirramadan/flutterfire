import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_data_controller.dart';

class AddDataView extends GetView<AddDataController> {
  const AddDataView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final addDataC = Get.find<AddDataController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('ADD DATA'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Data Form",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: controller.nameC,
                      decoration: const InputDecoration(
                          label: Text(
                            "Name",
                          ),
                          icon: Icon(Icons.person_rounded),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: controller.ageC,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          label: Text(
                            "Age",
                          ),
                          icon: Icon(Icons.numbers_rounded),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: controller.addressC,
                      decoration: const InputDecoration(
                          label: Text(
                            "Address",
                          ),
                          icon: Icon(Icons.place_rounded),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: MaterialButton(
                        height: 50,
                        textColor: Colors.white,
                        onPressed: () {
                          addDataC.addData(
                              controller.nameC.text,
                              controller.addressC.text,
                              int.parse(controller.ageC.text));
                        },
                        color: Colors.lightBlue,
                        child: const Text("ADD DATA"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
