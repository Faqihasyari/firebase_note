import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:myfirebase/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOMEVIEW'),
        centerTitle: true,
        actions: [
          GestureDetector(
              onTap: () {
                Get.toNamed(Routes.PROFILE);
              },
              child: Icon(Icons.person))
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: controller.streamNotes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            print(snapshot.data!.docs);
            if (snapshot.data?.docs.length == 0 || snapshot.data == null) {
              return const Center(child: Text("Belum Ada Notes Disini"));
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var docNote = snapshot.data!.docs[index];
                Map<String, dynamic> note = docNote.data();
                return ListTile(
                  onTap: () =>
                      Get.toNamed(Routes.EDIT_NOTE, arguments: docNote.id),
                  leading: CircleAvatar(
                    child: Text("${index + 1}"),
                  ),
                  title: Text("${note['title']}"),
                  subtitle: Text("${note['desc']}"),
                  trailing: IconButton(
                      onPressed: () {
                        controller.deleteNote(docNote.id);
                      },
                      icon: Icon(Icons.delete)),
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADD_NOTE);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
