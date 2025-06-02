import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const String dbName = 'hisab.db';
  final String customerTableName = 'customers';
  final String transactionTableName = 'transactions';

  Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() {
    return openDatabase(
      dbName,
      version: 1,
      onCreate: onCreate,
    );
  }

  onCreate(Database db, int version) async {
    // Create customers table
    await db.execute('''
      CREATE TABLE $customerTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        phone TEXT NOT NULL UNIQUE,
        is_sync INTEGER NOT NULL DEFAULT 0,
        currency TEXT,
        address TEXT,
        user_id TEXT NOT NULL,
        added_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    // Create transactions table with cascading behavior
    await db.execute('''
      CREATE TABLE $transactionTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        customer_id INTEGER NOT NULL,
        amount REAL NOT NULL,
        type TEXT NOT NULL,
        description TEXT,
        date TEXT NOT NULL,
        added_at TEXT NOT NULL DEFAULT (CURRENT_TIMESTAMP),
        updated_at TEXT NOT NULL DEFAULT (CURRENT_TIMESTAMP),
        FOREIGN KEY (customer_id) REFERENCES $customerTableName (id) 
          ON DELETE CASCADE 
          ON UPDATE CASCADE
      )
    ''');
  }

  static Future<void> deleteHisabDatabase() async {
    final String databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, dbName);
    await deleteDatabase(path);
  }
}
