import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void reset()async{
    if(emailC.text.isNotEmpty){
      isLoading.value = true;
    await auth.sendPasswordResetEmail(email: emailC.text);
      Get.back();
      Get.snackbar("BERHASIL", "Kami telah mengirimkan email ke alamat email Anda");
      isLoading.value = false;

    }
  }
}
