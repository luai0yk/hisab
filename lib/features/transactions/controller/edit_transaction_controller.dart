import 'package:get/get.dart';
import 'package:hisab/core/db/transaction/edit_transaction_db.dart';
import 'package:hisab/core/localization/locale_key.dart';
import 'package:hisab/features/transactions/controller/add_transaction_controller.dart';
import 'package:hisab/features/transactions/controller/transaction_data_controller.dart';
import 'package:hisab/features/transactions/model/transaction_model.dart';

class EditTransactionController extends AddTransactionController {
  late TransactionModel transaction;

  Future<void> editTransaction() async {
    await EditTransactionDB.instance.editTransaction(
      transactionId: transaction.id!,
      transaction: TransactionModel(
        amount: double.parse(amountController.text),
        description: descriptionController.text,
        type: realTransactionType,
        date: fullDate,
        updatedAt: DateTime.now().toString(),
      ),
    );
    Get.back();
  }

  @override
  void onInit() {
    transaction = Get.find<TransactionDataController>().transaction;
    amountController.text = transaction.amount.toString();
    descriptionController.text = transaction.description!;
    dateController.text = transaction.date!;
    typeController.value =
        transaction.type == 'gave' ? LocaleKey.gave.tr : LocaleKey.got.tr;
    super.onInit();
  }
}
