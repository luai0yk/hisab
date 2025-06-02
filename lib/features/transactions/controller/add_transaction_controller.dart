import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/core/db/add_transaction_db.dart';
import 'package:hisab/features/transactions/model/transaction_model.dart';
import 'package:hisab/shared/controller/customer_data_controller.dart';
import 'package:hisab/shared/model/customer_model.dart';
import 'package:jiffy/jiffy.dart';

class AddTransactionController extends GetxController {
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  SingleSelectController<String> typeController =
      SingleSelectController('gave');
  String? fullDate;

  @override
  void onInit() {
    setDateTime(dateTime: DateTime.now());
    super.onInit();
  }

  setDateTime({required DateTime dateTime}) {
    String formattedDate = Jiffy.parseFromDateTime(dateTime).format(
      pattern: 'yy-MM-dd',
    );
    fullDate = dateTime.toString();
    dateController.text = formattedDate;
  }

  Future<void> addTransaction() async {
    CustomerModel customer = Get.find<CustomerDataController>().customer;
    await AddTransactionDB.instance.addTransaction(
      transaction: TransactionModel(
        amount: double.tryParse(amountController.text),
        description: descriptionController.text,
        date: fullDate,
        type: typeController.value,
        customerId: customer.id,
        addedAt: DateTime.now().toString(),
        updatedAt: DateTime.now().toString(),
      ),
    );
    Get.back();
  }
}
