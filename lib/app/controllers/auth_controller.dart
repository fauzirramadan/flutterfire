import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_firebase/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  // Stream<User?> streamAuthStatus() {
  //   return auth.authStateChanges();
  // }

  Stream<User?> get streamAuthStatus =>
      auth.authStateChanges(); // memantau aktifitas login user

  void signUp(String email, String password) async {
    try {
      UserCredential myUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await myUser.user!.sendEmailVerification(); // kirim email verifikasi
      Get.defaultDialog(
          title: "Email Verifikasi",
          middleText: "Email verifikasi telah dikirimkan ke $email",
          textConfirm: "Ok, saya akan cek email",
          onConfirm: () {
            Get.back(); // close dialog
            Get.back(); // go to login
          });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
        Get.snackbar("Warning", "Password lemah",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 2));
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
        Get.snackbar("Warning", "Email sudah digunakan",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 2));
      } else if (!email.isEmail) {
        Get.snackbar("Warning", "Masukkan email yang valid!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 2));
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void login(String email, String password) async {
    try {
      UserCredential myUser = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (myUser.user!.emailVerified) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.defaultDialog(
            title: "Email Verifikasi",
            middleText:
                "Email belum diverifikasi, silahkan verifikasi terlebih dahulu",
            textConfirm: "Kirim email verifikasi",
            textCancel: "Cancel",
            onCancel: () => Get.back(),
            onConfirm: () async {
              await myUser.user!.sendEmailVerification();
              Get.snackbar("Email Verifikasi",
                  "Email verifikasi telah dikirim ke $email",
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM);
              Get.back();
            });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
        Get.snackbar("Warning", "User tidak ditemukan",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 2));
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
        Get.snackbar("Warning", "Password salah",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 2));
      }
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  void resetPassword(String email) async {
    Get.defaultDialog(
        title: "Reset password",
        onCancel: () => Get.back(),
        textCancel: "Cancel",
        middleText: "Apakah kamu yakin ingin reset password?",
        textConfirm: "Reset",
        confirmTextColor: Colors.red,
        onConfirm: () async {
          try {
            await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
            Get.back();
            Get.snackbar(
                "Alert", "Link reset password telah dikirim ke email kamu",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
                duration: const Duration(seconds: 3));
          } on FirebaseAuthException catch (e) {
            Get.back();
            Get.snackbar("Alert", "$e",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white,
                duration: const Duration(seconds: 3));
          }
        });
  }
}
