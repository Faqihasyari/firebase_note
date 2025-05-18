import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_note_controller.dart';

class AddNoteView extends GetView<AddNoteController> {
  const AddNoteView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADD NOTE'),
        centerTitle: true,
      ),
      body: ListView(
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
              controller.addNote();
            }
          }, child: Text(controller.isLoading.isFalse ? "ADD NOTE" : "LOADING...")),
        ],
      )
    );
  }
}
