import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC= TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void register(){
    if (emailC.text.isEmpty && passC.text.isEmpty){

    }
  }

}
