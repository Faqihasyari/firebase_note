import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:myfirebase/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();

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

  Future<void> getProfile() async {
    try {
      String uid = auth.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> docUser = await firestore.collection("user").doc(uid).get();
      print(docUser.data());
      // return docUser;
    } catch (e) {
       print(e);
      Get.snackbar("Terjadi Kesalahan", "Tidak dapat get data user");
    }
  }
}
