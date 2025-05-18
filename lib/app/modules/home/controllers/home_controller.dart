import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:myfirebase/app/routes/app_pages.dart';

class  HomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream streamNotes()async*{
    String uid = auth.currentUser!.uid;

    yield* await firestore.collection("users").doc(uid).collection("notes").snapshots();
  }
}
