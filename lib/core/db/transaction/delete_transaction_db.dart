import 'package:hisab/core/constants/database_key.dart';
import 'package:hisab/core/db/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class DeleteTransactionDB extends DatabaseHelper {
  static DeleteTransactionDB? _deleteTransactionDB;

  // Lazy singleton getter
  static DeleteTransactionDB get instance {
    _deleteTransactionDB ??= DeleteTransactionDB._intern();
    return _deleteTransactionDB!;
  }

  // Prevent the initialization of DeleteTransactionDB class
  DeleteTransactionDB._intern();

  Future<void> deleteTransaction({required int transactionId}) async {
    Database? db = await database;
    db!.delete(
      DatabaseKey.transactionTable,
      where: '${DatabaseKey.transactionId} = ?',
      whereArgs: [transactionId],
    );
  }
}
