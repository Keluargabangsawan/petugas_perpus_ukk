import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petugasperpus/app/data/constant/endpoint.dart';
import 'package:petugasperpus/app/data/provaider/API_provaider.dart';
import 'package:petugasperpus/app/routes/app_pages.dart';
import 'package:petugasperpus/app/data/provaider/storage_provaider.dart';



class AddBookController extends GetxController {
  //TODO: Implement AddBookController

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController judulController = TextEditingController();
  final TextEditingController penulisController = TextEditingController();
  final TextEditingController penerbitController = TextEditingController();
  final TextEditingController tahunController = TextEditingController();


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

  final loadingBook = false.obs;

  addBook() async {
    loadingBook(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        final response = await ApiProvider.instance().post(Endpoint.login,
            data:
            {
              "judul": judulController.text.toString(),
              "penulis": penulisController.text.toString(),
              "penerbit": penerbitController.text.toString(),
              "tahun_terbit": int.parse(tahunController.text.toString())
            }
        );
        if (response.statusCode == 200) {
          await StorageProvider.write(StorageKey.status, "logged");
          Get.offAllNamed(Routes.HOME);
        } else {
          Get.snackbar("Sorry", "Login Gagal", backgroundColor: Colors.orange);
        }
      }
      loadingBook(false);
    }on dio.DioException catch (e) {
      loadingBook(false);
      Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
    }catch (e) {
      loadingBook(false);
      Get.snackbar("Sorry", e.toString() ?? "", backgroundColor: Colors.red);
      throw Exception('Error $e');
    }
  }
}