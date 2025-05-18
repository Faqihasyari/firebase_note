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
        await firestore.collection("users").doc()
      } catch (e) {
      isLoading.value = true;

      Get.snackbar('Error', 'Tidak dapat menambahkan note');
        
      }
    } else {  
      Get.snackbar('Error', 'Please fill all fields');
    }
  }
}
