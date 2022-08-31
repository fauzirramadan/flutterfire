import 'package:first_firebase/app/controllers/auth_controller.dart';
import 'package:first_firebase/app/modules/signup/views/signup_view.dart';
import 'package:first_firebase/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final authC = Get.find<AuthController>();

  LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login Screen'),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: controller.emailC,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              TextField(
                obscureText: true,
                controller: controller.passwordC,
                decoration: const InputDecoration(labelText: "Password"),
              ),
              const SizedBox(
                height: 16,
              ),
              MaterialButton(
                color: Colors.blue,
                minWidth: 200,
                onPressed: () => authC.login(
                    controller.emailC.text, controller.passwordC.text),
                child: const Text(
                  "L O G I N",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Belum punya akun? ",
                    style: TextStyle(fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.SIGNUP),
                    child: const Text(
                      "Daftar disini",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
