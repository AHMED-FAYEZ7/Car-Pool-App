class UserModel {
  late String name;
  String? email;
  double rate = 4;
  String? phone;
  String? gender;
  bool? isEmailVerified = false;
  String? uId;

  UserModel({
    required this.name,
    this.email,
    this.phone,
    this.gender,
    this.isEmailVerified,
    this.uId,
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    isEmailVerified = json['isEmailVerified'];
    uId = json['uId'];
    rate = json['rate'] ?? 4;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'gender': gender,
      'isEmailVerified': isEmailVerified,
      'uId': uId,
      'rate' : rate
    };
  }
}
