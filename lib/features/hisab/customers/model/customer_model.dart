class CustomerModel {
  final int? id;
  final String? name;
  final String? phone;
  final String? address;
  final String? currency;
  final bool? isSynced;
  String? addedAt = '';
  String? updatedAt = '';

  CustomerModel({
    this.id,
    this.name,
    this.phone,
    this.address = '',
    this.currency,
    this.isSynced = false,
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
    };
  }
}
