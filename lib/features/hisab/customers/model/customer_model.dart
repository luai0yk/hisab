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
  });
  // Convert a map to CustomerModel
  factory CustomerModel.fromMap(Map<String, dynamic> map) {
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
    );
  }

  // Convert CustomerModel to a map
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
