import 'package:hisab/core/constants/database_key.dart';
import 'package:hisab/core/db/database_helper.dart';
import 'package:sqflite/sqflite.dart';

import '../../shared/model/customer_model.dart';

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

    // Your SQL query with user_id filter
    const String sql = '''
    SELECT 
      c.*,
      COALESCE(SUM(CASE WHEN t.type = 'gave' THEN t.amount ELSE 0 END), 0) AS total_debit,
      COALESCE(SUM(CASE WHEN t.type = 'got' THEN t.amount ELSE 0 END), 0) AS total_credit
      FROM ${DatabaseKey.customerTable} c
      LEFT JOIN ${DatabaseKey.transactionTable} t ON c.id = t.customer_id
      WHERE c.user_id = ?
      GROUP BY c.id
      ORDER BY c.id DESC;
      ''';

    // Run rawQuery with userId as argument
    List args = [userId];
    final List<Map<String, dynamic>> response = await db!.rawQuery(sql, args);

    // Map response to list of CustomerModel
    List<CustomerModel> customers = response.isNotEmpty
        ? response.map((e) => CustomerModel.fromMap(e)).toList()
        : [];

    return customers;
  }
}
