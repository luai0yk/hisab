import 'package:get/get.dart';
import 'package:hisab/core/db/transaction/view_transaction_db.dart';
import 'package:hisab/features/transactions/model/transaction_model.dart';
import 'package:hisab/shared/controller/customer_data_controller.dart';
import 'package:hisab/shared/model/customer_model.dart';

class ViewTransactionController extends GetxController {
  List<TransactionModel>? transactionList;

  CustomerModel customer = Get.find<CustomerDataController>().customer;
  Future<void> viewTransaction() async {
    transactionList = await ViewTransactionDB.instance.viewTransactions(
      customerID: customer.id,
    );

    update(['transaction_list']);
  }
}
