import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> getData() {
    CollectionReference dataUser = firestore.collection("users");
    return dataUser.snapshots();
  }
}
