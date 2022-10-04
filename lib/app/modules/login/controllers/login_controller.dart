import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController emailC =
      TextEditingController(text: "fauzirramadan@gmail.com");
  TextEditingController passwordC = TextEditingController(text: "F@uzi2002");

  @override
  void onClose() {
    emailC.dispose();
    passwordC.dispose();
    super.onClose();
  }
}
