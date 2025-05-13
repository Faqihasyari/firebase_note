import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myfirebase/app/modules/splash/splash.dart';
import 'package:myfirebase/firebase_options.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseAuth auth = FirebaseAuth.instance;
  await GetStorage.init();
  runApp(
    StreamBuilder <User?>(
      stream: auth.authStateChanges(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting){
          return SplashScreen();
        }
        return GetMaterialApp(
          title: "Application",
          initialRoute: snap.data != null && snap.data!.emailVerified == true ? Routes.LOGIN : Routes.LOGIN,
          getPages: AppPages.routes,
        );
      }
    ),
  );
}
