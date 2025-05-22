import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_note_controller.dart';

class EditNoteView extends GetView<EditNoteController> {
  const EditNoteView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditNoteView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EditNoteView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
