import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddNoteController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController titleC = TextEditingController();
  TextEditingController desC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addNote()async{
    if (titleC.text.isNotEmpty && desC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        String uid = auth.currentUser!.uid;
        await firestore.collection("users").doc(uid).collection("notes").add({
          "title": titleC.text,
          "desc": desC.text,
          "createdAt": DateTime.now().toIso8601String()
        });
      isLoading.value = false;
      Get.back();

      } catch (e) {
      isLoading.value = false;

      Get.snackbar('Error', 'Tidak dapat menambahkan note');
        
      }
    } else {  
      Get.snackbar('Error', 'Please fill all fields');
    }
  }
}
