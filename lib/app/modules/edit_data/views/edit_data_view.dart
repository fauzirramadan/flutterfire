import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_data_controller.dart';

class EditDataView extends GetView<EditDataController> {
  const EditDataView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = Get.parameters;

    return Scaffold(
      appBar: AppBar(
        title: const Text('EDIT DATA'),
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
                      decoration: InputDecoration(
                          hintText: "${data["dataName"]}",
                          icon: const Icon(Icons.person_rounded),
                          border: const OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: controller.ageC,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "${data["dataAge"]}",
                          icon: const Icon(Icons.numbers_rounded),
                          border: const OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: controller.addressC,
                      decoration: InputDecoration(
                          hintText: "${data["dataAddress"]}",
                          icon: const Icon(Icons.place_rounded),
                          border: const OutlineInputBorder()),
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
                          controller.updateUser(
                              controller.nameC.text,
                              controller.addressC.text,
                              int.parse(
                                controller.ageC.text,
                              ),
                              data["id"].toString());
                        },
                        color: Colors.lightBlue,
                        child: const Text("UPDATE DATA"),
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
