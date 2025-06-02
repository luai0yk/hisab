class DatabaseKey {
  // Database
  static const String dbName = 'hisab.db';

  // Table names
  static const String customerTable = 'customers';
  static const String transactionTable = 'transactions';

  // Customer table columns
  static const String customerId = 'id';
  static const String customerName = 'name';
  static const String customerPhone = 'phone';
  static const String customerIsSync = 'is_sync';
  static const String customerCurrency = 'currency';
  static const String customerAddress = 'address';
  static const String customerUserId = 'user_id';
  static const String customerAddedAt = 'added_at';
  static const String customerUpdatedAt = 'updated_at';

  // Transaction table columns
  static const String transactionId = 'id';
  static const String transactionCustomerId = 'customer_id';
  static const String transactionAmount = 'amount';
  static const String transactionType = 'type';
  static const String transactionDescription = 'description';
  static const String transactionDate = 'date';
  static const String transactionAddedAt = 'added_at';
  static const String transactionUpdatedAt = 'updated_at';
}
