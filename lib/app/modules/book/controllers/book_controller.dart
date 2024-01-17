import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petugasperpus/app/data/constant/endpoint.dart';
import 'package:petugasperpus/app/data/model/response_book.dart';
import 'package:petugasperpus/app/data/provaider/API_provaider.dart';


class BookController extends GetxController with StateMixin<List<DataBook>> {
  //TODO: Implement BookController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getData();
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
  Future<void> getData() async {
    change(null, status: RxStatus.loading());
    try{
      final response = await ApiProvider.instance().get(Endpoint.book);
      if(response.statusCode == 200){
        final Responbook responseBook = Responbook.fromJson(response.data);
        if(responseBook.data!.isEmpty){
          change(null, status: RxStatus.empty());
        }else{
          change(responseBook.data, status: RxStatus.success());
        }
      }else{
        change(null, status: RxStatus.error("Gagal mengambil data"));
      }
    } on DioException catch(e){
      change(null, status: RxStatus.error("Error ${e.message}"));
    } catch(e){
      change(null, status: RxStatus.error("Error : $e"));
    }
  }
}