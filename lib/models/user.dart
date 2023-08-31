class UserModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final String address;
  final String type;
  final String token;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.address,
      required this.type,
      required this.token});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'password': password,
      'address': address,
      'type': type,
      'token': token
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['_id'] ?? '',
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        password: json['password'] ?? '',
        address: json['address'] ?? '',
        type: json['type'] ?? '',
        token: json['token'] ?? ''
        );
  }
}
