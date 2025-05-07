import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:myfirebase/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void register() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      try {
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: passC.text,
        );
        print(userCredential);

        Get.offAllNamed(Routes.HOME);
      } on FirebaseAuthException catch (e) {
        print(e.code);
      } catch (e) {
        print(e);
      }
    }
  }
}
