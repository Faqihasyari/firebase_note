import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:myfirebase/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  RxBool isloading = false.obs;
  RxBool isHidden = true.obs;

  TextEditingController emailC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController passC= TextEditingController();


  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void logout() async {
    try {
      await auth.signOut();
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      print(e);
      Get.snackbar("Terjadi Kesalahan", "Tidak Bisa LogOut");
    }
  }

  Future<Map<String, dynamic>?> getProfile() async {
    try {
      String uid = auth.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> docUser =
          await firestore.collection("users").doc(uid).get();
      return docUser.data();
    } catch (e) {
      print(e);
      Get.snackbar("Terjadi Kesalahan", "Tidak dapat get data user");
      return null;
    }
  }

  void updateProfile() async {
    if(emailC.text.isNotEmpty && nameC.text.isNotEmpty && phoneC.text.isNotEmpty){
      try {
      isloading.value = true;
      String uid = auth.currentUser!.uid;

      await firestore.collection("users").doc(uid).update({
        "name": nameC.text,
        "phone": phoneC.text,
      });

      if(passC.text.isNotEmpty){
        //update password
        await  auth.currentUser!.updatePassword(passC.text);
        await auth.signOut();
        isloading.value = false;
        Get.offAllNamed(Routes.LOGIN);


      } else {
        isloading.value = false;
      }

      isloading.value = false;
    } catch (e) {
      isloading.value = false;

      print(e);
      Get.snackbar("Terjadi Kesalahan", "Tidak dapat update data user");
    }
    } else {
      Get.snackbar("Perhatian", "Isi semua form");
    }
    
  }
}
