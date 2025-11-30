import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/core/db/transaction/add_transaction_db.dart';
import 'package:hisab/core/db/transaction/delete_transaction_db.dart';
import 'package:hisab/core/db/transaction/edit_transaction_db.dart';
import 'package:hisab/core/db/transaction/view_transaction_db.dart';
import 'package:hisab/core/localization/locale_key.dart';
import 'package:hisab/features/transactions/model/transaction_model.dart';
import 'package:hisab/shared/model/customer_model.dart';
import 'package:jiffy/jiffy.dart';

class TransactionController extends GetxController {
  // Input fields
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  SingleSelectController<String> typeController =
      SingleSelectController(LocaleKey.gave.tr);

  String? fullDate;

  // Convert displayed type to real DB type
  String get realTransactionType =>
      typeController.value == LocaleKey.gave.tr ? 'gave' : 'got';

  @override
  void onInit() {
    setDateTime(dateTime: DateTime.now()); // set initial date
    super.onInit();
  }

  // Set date and formatted text
  void setDateTime({required DateTime dateTime}) {
    fullDate = dateTime.toString();
    dateController.text = Jiffy.parseFromDateTime(dateTime).format(
      pattern: 'yy-MM-dd',
    );
  }

  // Load data for editing a transaction
  void loadDataForEditPage(TransactionModel transaction) {
    amountController.text = transaction.amount.toString();
    descriptionController.text = transaction.description ?? '';
    dateController.text = transaction.date ?? '';
    typeController.value =
        transaction.type == 'gave' ? LocaleKey.gave.tr : LocaleKey.got.tr;
  }

  // Clear all input fields
  void clearControllers() {
    amountController.clear();
    descriptionController.clear();
    dateController.clear();
    typeController.value = LocaleKey.gave.tr;
    setDateTime(dateTime: DateTime.now());
  }

  // Add new transaction
  Future<void> addTransaction({required int customerId}) async {
    await AddTransactionDB.instance.addTransaction(
      transaction: TransactionModel(
        amount: double.tryParse(amountController.text),
        description: descriptionController.text,
        date: fullDate,
        type: realTransactionType,
        customerId: customerId,
        addedAt: DateTime.now().toString(),
        updatedAt: DateTime.now().toString(),
      ),
    );
    update(); // refresh UI
    Get.back();
  }

  // Edit existing transaction
  Future<void> editTransaction(int id) async {
    await EditTransactionDB.instance.editTransaction(
      transactionId: id,
      transaction: TransactionModel(
        amount: double.parse(amountController.text),
        description: descriptionController.text,
        date: fullDate,
        type: realTransactionType,
        updatedAt: DateTime.now().toString(),
      ),
    );
    update(); // refresh UI
    Get.back();
  }

  // Delete transaction
  Future<void> deleteTransaction(int id) async {
    await DeleteTransactionDB.instance.deleteTransaction(transactionId: id);
    update(); // refresh UI
  }

  // Get all transactions for a customer
  Future<List<TransactionModel>> getAllCustomerTransactions({
    required CustomerModel customer,
  }) async {
    return await ViewTransactionDB.instance.viewTransactions(
      customerID: customer.id!,
    );
  }
}
