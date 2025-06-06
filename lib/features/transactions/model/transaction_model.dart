import '../../../core/constants/database_key.dart';

class TransactionModel {
  final int? id;
  final int? customerId;
  final double? amount;
  final String? type; // 'got' or 'gave'
  final String? description;
  final bool? isSynced;
  final String? date;
  final String? addedAt;
  final String? updatedAt;

  TransactionModel({
    this.id,
    this.customerId,
    this.amount,
    this.type,
    this.isSynced = false,
    this.description,
    this.date,
    this.addedAt,
    this.updatedAt,
  });

  // Convert a map to TransactionModel
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map[DatabaseKey.transactionId],
      customerId: map[DatabaseKey.transactionCustomerId],
      amount: map[DatabaseKey.transactionAmount],
      type: map[DatabaseKey.transactionType],
      isSynced: map[DatabaseKey.transactionIsSync] == 1,
      description: map[DatabaseKey.transactionDescription],
      date: map[DatabaseKey.transactionDate],
      addedAt: map[DatabaseKey.transactionAddedAt],
      updatedAt: map[DatabaseKey.transactionUpdatedAt],
    );
  }

  // Convert TransactionModel to a map
  Map<String, dynamic> toMap() {
    return {
      DatabaseKey.transactionId: id,
      DatabaseKey.transactionCustomerId: customerId,
      DatabaseKey.transactionAmount: amount,
      DatabaseKey.transactionType: type,
      DatabaseKey.transactionIsSync: isSynced == true ? 1 : 0,
      DatabaseKey.transactionDescription: description,
      DatabaseKey.transactionDate: date,
      DatabaseKey.transactionAddedAt: addedAt,
      DatabaseKey.transactionUpdatedAt: updatedAt,
    };
  }

  Map<String, dynamic> toMapEdit() {
    return {
      DatabaseKey.transactionAmount: amount,
      DatabaseKey.transactionType: type,
      DatabaseKey.transactionDescription: description,
      DatabaseKey.transactionDate: date,
      DatabaseKey.transactionIsSync: isSynced == true ? 1 : 0,
      DatabaseKey.transactionUpdatedAt: updatedAt,
    };
  }
}
