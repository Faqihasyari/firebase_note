import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('REGISTER'),
          centerTitle: true,
        ),
        body: ListView(
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
              controller: controller.passC,
              decoration: InputDecoration(
                  labelText: "Password", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            Obx(
              () => ElevatedButton(
                  onPressed: () {
                    if (controller.isLoading.isFalse) {
                      //eksekusi login
                      controller.register();
                    }
                  },
                  child: Text(
                      controller.isLoading.isFalse ? "LOGIN" : "LOADING....")),
            ),
          ],
        ));
  }
}
