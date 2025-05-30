import 'package:hisab/core/db/database_helper.dart';
import 'package:hisab/features/hisab/customers/model/customer_model.dart';
import 'package:sqflite/sqflite.dart';

class AddCustomerDB extends DatabaseHelper {
  static AddCustomerDB? _createCustomer;

  // Lazy singleton getter
  static AddCustomerDB get instance {
    _createCustomer ??= AddCustomerDB._intern();
    return _createCustomer!;
  }

  // Prevent the initialization of CreateCustomer class
  AddCustomerDB._intern();

  Future<bool> isPhoneUsed({
    required String phone,
    required String userId,
  }) async {
    Database? db = await database;
    var response = await db!.query(
      customerTableName,
      where: 'phone == ? AND user_id == ?',
      whereArgs: [phone, userId],
    );
    return response.isNotEmpty;
  }

  Future<void> addedCustomer({required CustomerModel customer}) async {
    Database? db = await database;
    await db!.insert(
      customerTableName,
      customer.toMap(),
    );
  }
}
