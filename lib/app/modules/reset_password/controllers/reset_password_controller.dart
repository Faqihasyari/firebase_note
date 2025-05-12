import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void errMsg(String msg) {
    Get.snackbar('TERJADI KESLAHAN', msg);
  }

  void reset() async {
    if (emailC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await auth.sendPasswordResetEmail(email: emailC.text);
        isLoading.value = false;
        Get.back();
        Get.snackbar(
            "BERHASIL", "Kami telah mengirimkan email ke alamat email Anda");
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        errMsg(e.code);
      } catch (e) {
        errMsg("Tidak dapat reset password ke email ini");
        isLoading.value = false;
      }
    } else {
      errMsg('Email belum di isi');
    }
  }
}
