import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> getData() {
    CollectionReference dataUser = firestore.collection("users");
    return dataUser.orderBy("time", descending: true).snapshots();
  }

  Future<void> deleteData(String docId) {
    CollectionReference docRef = firestore.collection("users");
    return docRef.doc(docId).delete();
  }
}
