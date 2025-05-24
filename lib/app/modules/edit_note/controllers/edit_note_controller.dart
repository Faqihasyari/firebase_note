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
  
  
  void editNote (){}
}
