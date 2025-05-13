import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myfirebase/app/routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool rememberMe = false.obs;
  RxBool isLHidden = true.obs;
  TextEditingController emailC =
      TextEditingController();
  TextEditingController passC = TextEditingController( );

  FirebaseAuth auth = FirebaseAuth.instance;

  final box = GetStorage();

  void errMsg(String msg) {
    Get.snackbar("ERROR", msg);
  }

  void login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailC.text,
          password: passC.text,
        );
        print(userCredential);
        isLoading.value = false;

        if (userCredential.user!.emailVerified == true) {
          if(box.read("rememberMe") != null){
            await box.remove("rememberMe");
          }
          if (rememberMe.isTrue){
            await box.write("rememberMe", {
              "email": emailC.text,
              "pass": passC.text,
            });
          }
          Get.offAllNamed(Routes.HOME);
        } else {
          print('User belum terverifikasi & tidak bisa login');
          Get.defaultDialog(
              title: "Belum terverifikasi",
              middleText:
                  "Apakah kamu ingin mengirimkan email verifikasi kembali?",
              actions: [
                OutlinedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("TIDAK")),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        await userCredential.user!.sendEmailVerification();
                        Get.back();
                        print("Berhasil mengirim email verifikasi");
                        Get.snackbar("BERHASIL",
                            "Kami Telah Mengirimkan Email Verifikasi");
                      } catch (e) {
                        Get.back();
                        errMsg(
                            "Kamu terlalu cepat meminta kirim email verifikasi");
                      }
                    },
                    child: Text("KIRIM LAGI"))
              ]);
        }
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        print(e.code);
        errMsg(e.code);
      }
    } else {
      errMsg("Email dan Password tidak boleh kosong");
    }
  }
}
