import 'package:hisab/core/constants/database_key.dart';
import 'package:hisab/core/db/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class DeleteCustomerDB extends DatabaseHelper {
  Future<void> deleteCustomer({required customerID}) async {
    Database? db = await database;
    await db!.delete(
      DatabaseKey.customerTable,
      where: '${DatabaseKey.customerId} = ?',
      whereArgs: [customerID],
    );
  }
}
