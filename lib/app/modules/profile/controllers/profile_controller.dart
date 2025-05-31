import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myfirebase/app/routes/app_pages.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController {
  RxBool isloading = false.obs;
  RxBool isHidden = true.obs;
  var imageUrl = ''.obs;

  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  SupabaseClient supabase = Supabase.instance.client;

  void showAvatarOptions() {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        padding: EdgeInsets.all(16),
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo),
              title: Text("Ubah Foto Profil"),
              onTap: () {
                Get.back();
                updateImage();
              },
            ),
            ListTile(
              leading: Icon(Icons.download),
              title: Text("Simpan Foto Profil"),
              onTap: () {
                Get.back();
                downloadImageToLocal();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> downloadImageToLocal() async {
    if (imageUrl.value.isEmpty) {
      Get.snackbar("Info", "Belum ada foto untuk disimpan");
      return;
    }

    try {
      final response = await http.get(Uri.parse(imageUrl.value));
      final bytes = response.bodyBytes;

      final directory = await getApplicationDocumentsDirectory();
      final filePath = "${directory.path}/foto_profil.jpg";

      final file = File(filePath);
      await file.writeAsBytes(bytes);

      Get.snackbar("Sukses", "Foto disimpan di: $filePath");
    } catch (e) {
      Get.snackbar("Gagal", "Gagal menyimpan foto: $e");
    }
  }

  Future<void> updateImage() async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final fileName =
          '${DateTime.now().microsecondsSinceEpoch}.jpg';

      try {
        //upload ke supabase
        await supabase.storage.from('profile').upload(fileName, file);

        //ambil public URL nya
        final publicUrl =
            supabase.storage.from('profile').getPublicUrl(fileName);

        imageUrl.value = publicUrl;
        print('Upload sudah berhasil: $publicUrl');
      } catch (e) {
        print(e);
      }
    }
  }

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
    if (emailC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        phoneC.text.isNotEmpty) {
      try {
        isloading.value = true;
        String uid = auth.currentUser!.uid;

        await firestore.collection("users").doc(uid).update({
          "name": nameC.text,
          "phone": phoneC.text,
        });

        if (passC.text.isNotEmpty) {
          //update password
          await auth.currentUser!.updatePassword(passC.text);
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
