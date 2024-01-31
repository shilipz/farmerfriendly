// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String? uid;
  String? username;
  String? email;
  String? password;
  String? fullName;
  String? phoneNumber;
  String? houseName;
  String? streetName;
  String? landmark;
  int? pincode;

  UserModel(
      {this.uid,
      this.username,
      this.email,
      this.password,
      this.fullName,
      this.phoneNumber,
      this.houseName,
      this.streetName,
      this.landmark,
      this.pincode});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'username': username,
      'email': email,
      'password': password,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'houseName': houseName,
      'streetName': streetName,
      'landmark': landmark,
      'pincode': pincode,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      houseName: map['houseName'] != null ? map['houseName'] as String : null,
      streetName:
          map['streetName'] != null ? map['streetName'] as String : null,
      landmark: map['landmark'] != null ? map['landmark'] as String : null,
      pincode: map['pincode'] != null ? map['pincode'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
