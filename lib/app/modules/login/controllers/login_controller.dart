import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:myfirebase/app/routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC =
      TextEditingController(text: "faqih8158@gmail.com");
  TextEditingController passC = TextEditingController(text: "password");

  FirebaseAuth auth = FirebaseAuth.instance;
  void login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      try {
        isLoading.value = true;
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailC.text,
          password: passC.text,
        );
        print(userCredential);
        isLoading.value = false;

        Get.offAllNamed(Routes.HOME);
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        print(e.code);
      }
    }
  }
}
