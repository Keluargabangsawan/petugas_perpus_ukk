import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginView'),
        centerTitle: true,
      ),
      body: Center(
        child: Form(key:  controller.formKey,
        child: Column(
          children: [
            TextFormField(
              controller: controller.passwordController,
              decoration: InputDecoration(
                hintText: "masukan username"),
                validator: ( value){
                if(value!.isEmpty){
                  return "username tidak boleh kosong";
                }
                return null;
          },
              ),
            TextFormField (
              controller: controller.passwordController,
              decoration: InputDecoration(
                  hintText: "masukan password"),
              validator: ( value){
                if(value!.isEmpty){
                  return "password tidak boleh kosong";
                }
                return null;
              },
            ),

            Obx(() =>
            controller.loadingLogin.value?
            CircularProgressIndicator():
            ElevatedButton(onPressed: (){
              controller.login();

            },

                child: Text("login")),
            )
          ],

        ),
        )),
      );

  }
}
