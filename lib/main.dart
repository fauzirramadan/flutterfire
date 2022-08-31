import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_firebase/app/controllers/auth_controller.dart';
import 'package:first_firebase/app/modules/home/views/home_view.dart';
import 'package:first_firebase/app/modules/login/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/utils/loading_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController(), permanent: true);
    return StreamBuilder<User?>(
        stream: authC.streamAuthStatus,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            print(snapshot.data);
            return GetMaterialApp(
              title: "Application",
              initialRoute: snapshot.data != null ? Routes.HOME : Routes.LOGIN,
              // home: snapshot.data != null ? HomeView() : LoginView(),
              getPages: AppPages.routes,
            );
          }
          return const LoadingView();
        });
  }
}
