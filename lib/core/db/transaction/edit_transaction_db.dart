import 'package:hisab/core/constants/database_key.dart';
import 'package:hisab/core/db/database_helper.dart';
import 'package:hisab/features/transactions/model/transaction_model.dart';
import 'package:sqflite/sqflite.dart';

class EditTransactionDB extends DatabaseHelper {
  static EditTransactionDB? _editTransactionDB;

  // Lazy singleton getter
  static EditTransactionDB get instance {
    _editTransactionDB ??= EditTransactionDB._intern();
    return _editTransactionDB!;
  }

  // Prevent the initialization of EditTransactionDB class
  EditTransactionDB._intern();

  Future<void> editTransaction({
    required int transactionId,
    required TransactionModel transaction,
  }) async {
    Database? db = await database;

    db!.update(
      DatabaseKey.transactionTable,
      transaction.toMapEdit(),
      where: '${DatabaseKey.transactionId} = ?',
      whereArgs: [transactionId],
    );
  }
}
