import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myfirebase/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    if (box.read("rememberMe") != null) {
      controller.emailC.text = box.read("rememberMe")["email"];
      controller.passC.text = box.read("rememberMe")["pass"];
      controller.rememberMe.value = true;
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('LoginView'),
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
            Obx(
              () => TextField(
                obscureText: controller.isLHidden.value,
                controller: controller.passC,
                decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: () {
                          controller.isLHidden.toggle();
                        },
                        icon: Icon(controller.isLHidden.isTrue
                            ? Icons.remove_red_eye
                            : Icons.visibility_off))),
              ),
            ),
            Obx(
              () => CheckboxListTile(
                value: controller.rememberMe.value,
                onChanged: (value) {
                  controller.rememberMe.toggle();
                },
                title: Text('Remember Me'),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 150,
                  child: TextButton(
                    onPressed: () => Get.toNamed(Routes.RESET_PASSWORD),
                    child: Text("Forgor Password?"),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Obx(
              () => ElevatedButton(
                  onPressed: () {
                    if (controller.isLoading.isFalse) {
                      //eksekusi login
                      controller.login();
                    }
                  },
                  child: Text(
                      controller.isLoading.isFalse ? "LOGIN" : "LOADING....")),
            ),
            TextButton(
              onPressed: () => Get.toNamed(Routes.REGISTER),
              child: Text("Register"),
            )
          ],
        ));
  }
}
