import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../constants/database_key.dart';

class DatabaseHelper {
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() {
    return openDatabase(
      DatabaseKey.dbName,
      version: 1,
      onCreate: onCreate,
    );
  }

  onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${DatabaseKey.customerTable} (
        ${DatabaseKey.customerId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DatabaseKey.customerName} TEXT NOT NULL,
        ${DatabaseKey.customerPhone} TEXT NOT NULL UNIQUE,
        ${DatabaseKey.customerIsSync} INTEGER NOT NULL DEFAULT 0,
        ${DatabaseKey.customerCurrency} TEXT,
        ${DatabaseKey.customerAddress} TEXT,
        ${DatabaseKey.customerUserId} TEXT NOT NULL,
        ${DatabaseKey.customerAddedAt} TEXT NOT NULL,
        ${DatabaseKey.customerUpdatedAt} TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE ${DatabaseKey.transactionTable} (
        ${DatabaseKey.transactionId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DatabaseKey.transactionCustomerId} INTEGER NOT NULL,
        ${DatabaseKey.transactionAmount} REAL NOT NULL,
        ${DatabaseKey.transactionType} TEXT NOT NULL,
        ${DatabaseKey.transactionDescription} TEXT,
        ${DatabaseKey.transactionDate} TEXT NOT NULL,
        ${DatabaseKey.transactionAddedAt} TEXT NOT NULL,
        ${DatabaseKey.transactionUpdatedAt} TEXT NOT NULL,
        FOREIGN KEY (${DatabaseKey.transactionCustomerId}) REFERENCES ${DatabaseKey.customerTable} (${DatabaseKey.customerId})
          ON DELETE CASCADE 
          ON UPDATE CASCADE
      )
    ''');
  }

  static Future<void> deleteHisabDatabase() async {
    final String databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, DatabaseKey.dbName);
    await deleteDatabase(path);
  }
}
