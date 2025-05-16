import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
        body: FutureBuilder<Map<String, dynamic>?>(
            future: controller.getProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.data == null) {
                return Center(
                  child: Text('No data'),
                );
              } else {
                controller.emailC.text = snapshot.data!["email"];
                controller.nameC.text = snapshot.data!["name"];
                controller.phoneC.text = snapshot.data!["phone"];

                return ListView(
                  padding: EdgeInsets.all(20),
                  children: [
                    TextField(
                      controller: controller.emailC,
                      readOnly: true,
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
                    TextField(
                      controller: controller.phoneC,
                      decoration: InputDecoration(
                          labelText: "New Password", border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Created At :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(DateFormat.yMMMEd()
                        .add_jms()
                        .format(DateTime.parse(snapshot.data!["createdAt"]))),
                    SizedBox(
                      height: 40,
                    ),
                    Obx(
                      () => ElevatedButton(
                          onPressed: () {
                            if (controller.isloading.isFalse){
                              controller.updateProfile();
                            }
                          }, child: Text(controller.isloading.isFalse ? "LOADING...." : "UPDATE PROFILE")),
                    )
                  ],
                );
              }
            }));
  }
}
