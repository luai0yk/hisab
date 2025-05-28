class UserModel {
  String id;
  String fullName;
  String? email;
  String? password;

  UserModel({
    this.id = '',
    this.fullName = '',
    this.email,
    this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      fullName: json['full_name'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = fullName;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
