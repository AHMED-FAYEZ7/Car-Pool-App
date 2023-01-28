class UserModel {
  late String name;
  String? email;
  String? phone;
  String? gender;
  bool? isEmailVerified;
  String? uId;

  UserModel({
    required this.name,
    this.email,
    this.phone,
    this.gender,
    this.isEmailVerified,
    this.uId,
  });

  UserModel.fromJson(Map<String,dynamic>? json)
  {
    name = json!['name'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    isEmailVerified = json['isEmailVerified'];
    uId = json['uId'];
  }

  Map<String,dynamic> toMap()
  {
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'gender':gender,
      'isEmailVerified':isEmailVerified,
      'uId':uId,
    };
  }
}