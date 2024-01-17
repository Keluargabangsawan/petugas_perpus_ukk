import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/book_controller.dart';

class BookView extends GetView<BookController> {
  const BookView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('BookView'),
          centerTitle: true,
        ),
        body: controller.obx((state) =>
            ListView.separated(itemBuilder: (context, index) {
              return ListTile(
                title: Text(state[index].judul ?? "-"),
                subtitle: Text('penulis${state![index].penulis??'-'}'),
              );
            },
              separatorBuilder: (context, index){
                return Divider();
              },
              itemCount: state!.length,)
        )
    );
  }

}