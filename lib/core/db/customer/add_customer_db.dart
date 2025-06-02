import 'package:hisab/core/constants/database_key.dart';
import 'package:hisab/core/db/database_helper.dart';
import 'package:sqflite/sqflite.dart';

import '../../../shared/model/customer_model.dart';

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
  }) async {
    Database? db = await database;
    var response = await db!.query(DatabaseKey.customerTable,
        where: '${DatabaseKey.customerPhone} == ?', whereArgs: [phone]);
    return response.isNotEmpty;
  }

  Future<void> addedCustomer({required CustomerModel customer}) async {
    Database? db = await database;
    await db!.insert(
      DatabaseKey.customerTable,
      customer.toMap(),
    );
  }
}
