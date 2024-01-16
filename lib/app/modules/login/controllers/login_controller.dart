import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:petugasperpus/app/data/constant/endpoint.dart';
import 'package:petugasperpus/app/data/provaider/API_provaider.dart';
import 'package:petugasperpus/app/data/provaider/storage_provaider.dart';
import 'package:petugasperpus/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  final loadingLogin = false.obs;

  login() async {
    loadingLogin(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        final response = await ApiProvider.instance().post(Endpoint.login,
            data: dio.FormData.fromMap(
                {
                  "username": usernameController.text.toString(),
                  "password": passwordController.text.toString()
                }));
        if (response.statusCode == 200) {
          await StorageProvider.write(StorageKey.status, "logged");
          Get.offAllNamed(Routes.HOME);
        } else {
          Get.snackbar("Sorry", "Login Gagal", backgroundColor: Colors.orange);
        }
      }
      loadingLogin(false);
    }on dio.DioException catch (e) {
      loadingLogin(false);
      Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
    }catch (e) {
      loadingLogin(false);
      Get.snackbar("Sorry", e.toString() ?? "", backgroundColor: Colors.red);
      throw Exception('Error $e');
    }
  }
}