import 'package:hisab/core/db/database_helper.dart';
import 'package:sqflite/sqflite.dart';

import '../../features/customers/model/customer_model.dart';

class ViewCustomerDB extends DatabaseHelper {
  static ViewCustomerDB? _viewCustomer;

  //Lazy Singleton getter
  static ViewCustomerDB get instance {
    _viewCustomer ??= ViewCustomerDB._intern();
    return _viewCustomer!;
  }

  // Prevent the initialization of ViewCustomer class
  ViewCustomerDB._intern();

  Future<List<CustomerModel>> viewCustomers({required String userId}) async {
    Database? db = await database;
    var response = await db!.query(
      customerTableName,
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'id DESC',
    );

    List<CustomerModel> customers = response.isNotEmpty
        ? response.map((e) => CustomerModel.fromMap(e)).toList()
        : [];

    return customers;
  }
}
