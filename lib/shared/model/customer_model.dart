import '../../core/constants/database_key.dart';

class CustomerModel {
  final int? id;
  final String? name;
  final String? phone;
  final String? address;
  final String? currency;
  final bool? isSynced;
  final String? userID;
  final String? addedAt;
  final String? updatedAt;
  final double totalGivenAmount;
  final double totalGottenAmount;
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
    this.totalGivenAmount = 0.0,
    this.totalGottenAmount = 0.0,
    double? netBalance,
  }) : netBalance = netBalance ?? (totalGottenAmount - totalGivenAmount).abs();

  bool get isCustomerGiven => totalGivenAmount > totalGottenAmount;
  bool get isCustomerEmpty => netBalance == 0;
  bool get isCustomerSettled =>
      totalGottenAmount > 0 && totalGivenAmount > 0 && netBalance == 0;

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    final double debit =
        (map['total_debit'] ?? 0).toDouble(); // From JOIN/AGG query
    final double credit =
        (map['total_credit'] ?? 0).toDouble(); // From JOIN/AGG query

    return CustomerModel(
      id: map[DatabaseKey.customerId],
      name: map[DatabaseKey.customerName],
      phone: map[DatabaseKey.customerPhone],
      address: map[DatabaseKey.customerAddress],
      currency: map[DatabaseKey.customerCurrency],
      isSynced: map[DatabaseKey.customerIsSync] == 1,
      userID: map[DatabaseKey.customerUserId],
      addedAt: map[DatabaseKey.customerAddedAt],
      updatedAt: map[DatabaseKey.customerUpdatedAt],
      totalGivenAmount: debit,
      totalGottenAmount: credit,
      netBalance: (credit - debit).abs(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseKey.customerId: id,
      DatabaseKey.customerName: name,
      DatabaseKey.customerPhone: phone,
      DatabaseKey.customerAddress: address,
      DatabaseKey.customerCurrency: currency,
      DatabaseKey.customerIsSync: isSynced == true ? 1 : 0,
      DatabaseKey.customerUserId: userID,
      DatabaseKey.customerAddedAt: addedAt,
      DatabaseKey.customerUpdatedAt: updatedAt,
    };
  }

  Map<String, dynamic> toMapEdit() {
    return {
      DatabaseKey.customerName: name,
      DatabaseKey.customerPhone: phone,
      DatabaseKey.customerAddress: address,
      DatabaseKey.customerCurrency: currency,
      DatabaseKey.customerIsSync: isSynced == true ? 1 : 0,
      DatabaseKey.customerUpdatedAt: updatedAt,
    };
  }
}
