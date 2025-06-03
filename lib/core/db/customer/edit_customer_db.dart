import 'package:hisab/core/constants/database_key.dart';
import 'package:hisab/core/db/database_helper.dart';
import 'package:hisab/shared/model/customer_model.dart';
import 'package:sqflite/sqflite.dart';

class EditCustomerDB extends DatabaseHelper {
  static EditCustomerDB? _editCustomerDB;

  //Lazy Singleton getter
  static EditCustomerDB get instance {
    _editCustomerDB ??= EditCustomerDB._intern();
    return _editCustomerDB!;
  }

  // Prevent the initialization of EditCustomerDB class
  EditCustomerDB._intern();

  Future<void> editCustomer({required CustomerModel customer}) async {
    Database? db = await database;

    db!.update(DatabaseKey.customerTable, customer.toMapEdit());
  }
}
