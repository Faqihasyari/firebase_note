import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:myfirebase/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  RxBool isLHidden = true.obs;
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();

  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance; 

  void errMsg(String msg) {
    Get.snackbar("ERROR", msg);
  }

//function resister
  void register() async {
    isLoading.value = true;
    if (nameC.text.isNotEmpty &&
        phoneC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        passC.text.isNotEmpty) {
      try {
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: passC.text,
        );
        print(userCredential);

        isLoading.value = false;

        //KIRIM LINK EMAIL VERIFIKASI
        await userCredential.user!.sendEmailVerification();

        firestore.collection("users").doc(userCredential.user!.uid).set({
          "name": nameC.text,
          "phone": phoneC.text,
          "email": emailC.text,
          "uid": userCredential.user!.uid,
          "createdAt": DateTime.now().toIso8601String()
        });

        Get.offAllNamed(Routes.LOGIN);
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        errMsg(e.code);

        print(e.code);
      } catch (e) {
        isLoading.value = false;
        errMsg("$e");

        print(e);
      }
    } else {
      errMsg("Email dan password tidak boleh kosong");
    }
  }
}
