import 'package:hisab/core/db/database_helper.dart';
import 'package:hisab/features/transactions/model/transaction_model.dart';
import 'package:sqflite/sqflite.dart';

class ViewTransactionDB extends DatabaseHelper {
  static ViewTransactionDB? _viewTransaction;

  // Lazy singleton getter
  static ViewTransactionDB get instance {
    _viewTransaction ??= ViewTransactionDB._intern();
    return _viewTransaction!;
  }

  // Prevent the initialization of CreateCustomer class
  ViewTransactionDB._intern();

  Future<List<TransactionModel>> viewTransactions({required customerID}) async {
    Database? db = await database;
    // Run rawQuery with userId as argument
    final List<Map<String, dynamic>> response = await db!.query(
        transactionTableName,
        where: 'customer_id = ?',
        whereArgs: [customerID]);

    List<TransactionModel> customers = response.isNotEmpty
        ? response.map((e) => TransactionModel.fromMap(e)).toList()
        : [];

    return customers;
  }
}
