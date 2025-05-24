import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_note_controller.dart';

class EditNoteView extends GetView<EditNoteController> {
  const EditNoteView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EDIT NOTE'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: controller.getNoteById(Get.arguments.toString()),
        builder: (context, snapshot) {
          return ListView(
            padding: EdgeInsets.all(20),
            children: [
              TextField(
                controller: controller.titleC,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title'
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: controller.desC,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description'
                ),
              ),
              SizedBox(height: 30,),
              ElevatedButton(onPressed: () {
                if (controller.isLoading.isFalse) {
                  controller.editNote();
                }
              }, child: Text(controller.isLoading.isFalse ? "ADD NOTE" : "LOADING...")),
            ],
          );
        }
      )
    );
  }
}
