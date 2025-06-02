class CustomerModel {
  final int? id;
  final String? name;
  final String? phone;
  final String? address;
  final String? currency;
  final bool? isSynced;
  final String? userID;
  String? addedAt = '';
  String? updatedAt = '';
  final double totalDebit;
  final double totalCredit;
  final double netBalance;

  CustomerModel({
    this.id,
    this.name,
    this.phone,
    this.address = '',
    this.currency,
    this.isSynced = false,
    this.userID,
    this.addedAt,
    this.updatedAt,
    this.totalDebit = 0.0,
    this.totalCredit = 0.0,
    double? netBalance, // Optional override
  }) : netBalance = netBalance ?? (totalCredit - totalDebit);

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    final double debit = (map['total_debit'] ?? 0).toDouble();
    final double credit = (map['total_credit'] ?? 0).toDouble();

    return CustomerModel(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      address: map['address'],
      currency: map['currency'],
      isSynced: map['is_sync'] == 1,
      userID: map['user_id'],
      addedAt: map['added_at'],
      updatedAt: map['updated_at'],
      totalDebit: debit,
      totalCredit: credit,
      netBalance: credit - debit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'address': address,
      'currency': currency,
      'is_sync': isSynced == true ? 1 : 0,
      'user_id': userID,
    };
  }
}
