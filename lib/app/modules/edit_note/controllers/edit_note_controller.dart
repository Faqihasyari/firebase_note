import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EditNoteController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController titleC = TextEditingController();
  TextEditingController desC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getNoteById (String docID) async {
    try {
      
    String uid = auth.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> doc = await firestore.collection('users').doc(uid).collection('notes').doc(docID).get();
    return doc.data();
    } catch (e) {
      print(e);
      return null;
    }


  }
  
  
  void editNote (String docID)async{
    if (titleC.text.isNotEmpty && desC.text.isNotEmpty) {
      
    isLoading.value = true;
    try {
      
    String uid = auth.currentUser!.uid;
    await firestore.collection('users').doc(uid).collection('notes').doc(docID).update({
      "title": titleC.text,
      "desc": desC.text,
    });
    isLoading.value = false;


    Get.back();
    } catch (e) {
      print(e);
    isLoading.value = false;
    Get.snackbar('Error', 'Tidak dapat mengubah note ini');
    }
    } else {
      Get.snackbar('Error', 'Judul dan deskripsi tidak boleh kosong');
    }
  }
}
