import 'package:hisab/core/constants/database_key.dart';
import 'package:hisab/core/db/database_helper.dart';
import 'package:hisab/features/transactions/model/transaction_model.dart';
import 'package:sqflite/sqflite.dart';

class AddTransactionDB extends DatabaseHelper {
  static AddTransactionDB? _addTransaction;

  // Lazy singleton getter
  static AddTransactionDB get instance {
    _addTransaction ??= AddTransactionDB._intern();
    return _addTransaction!;
  }

  // Prevent the initialization of CreateCustomer class
  AddTransactionDB._intern();

  Future<void> addTransaction({required TransactionModel transaction}) async {
    Database? db = await database;
    await db!.insert(
      DatabaseKey.transactionTable,
      transaction.toMap(),
    );
  }
}
