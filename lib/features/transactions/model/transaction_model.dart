class TransactionModel {
  final int? id;
  final int? customerId;
  final double? amount;
  final String? type; // 'got' or 'gave'
  final String? description;
  final String? date;
  final String? addedAt;
  final String? updatedAt;

  TransactionModel({
    this.id,
    this.customerId,
    this.amount,
    this.type,
    this.description,
    this.date,
    this.addedAt = '',
    this.updatedAt = '',
  });

  // Convert a map to TransactionModel
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      customerId: map['customer_id'],
      amount: map['amount'],
      type: map['type'],
      description: map['description'],
      date: map['date'],
      addedAt: map['added_at'],
      updatedAt: map['updated_at'],
    );
  }

  // Convert TransactionModel to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customer_id': customerId,
      'amount': amount,
      'type': type,
      'description': description,
      'date': date,
    };
  }
}
