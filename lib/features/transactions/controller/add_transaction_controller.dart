import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class AddTransactionController extends GetxController {
  TextEditingController dateController = TextEditingController();
  SingleSelectController<String> typeController =
      SingleSelectController('Gave');

  @override
  void onInit() {
    setDateTime(dateTime: DateTime.now());
    super.onInit();
  }

  setDateTime({required DateTime dateTime}) {
    String formattedDate =
        Jiffy.parseFromDateTime(dateTime).format(pattern: 'yy-MM-dd');

    dateController.text = formattedDate;
  }
}
