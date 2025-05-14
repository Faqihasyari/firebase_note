import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ProfileView'),
          centerTitle: true,
           actions: [
          IconButton(
              onPressed: () {
                controller.logout();
              },
              icon: Icon(Icons.logout))
        ],
        ),
        body: FutureBuilder(
          future: controller.getProfile,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
              padding: EdgeInsets.all(20),
              children: [
                TextField(
                  controller: controller.emailC,
                  decoration: InputDecoration(
                      labelText: "Email", border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: controller.nameC,
                  decoration: InputDecoration(
                      labelText: "Name", border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: controller.phoneC,
                  decoration: InputDecoration(
                      labelText: "Phone", border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            );
          }
        ));
  }
}
