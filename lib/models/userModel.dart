// To parse this JSON data, do
//
//     final userDataModel = userDataModelFromJson(jsonString);

import 'dart:convert';

UserDataModel userDataModelFromJson(String str) => UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  UserDataModel({
    this.message,
    this.user,
    this.accessToken,
  });

  String message;
  User user;
  String accessToken;

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
    message: json["message"],
    user: User.fromJson(json["user"]),
    accessToken: json["access_token"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "user": user.toJson(),
    "access_token": accessToken,
  };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.verified,
    this.verificationToken,
    this.phoneVerified,
    this.emailVerifiedAt,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.bannedAt,
    this.deactivatedAt,
    this.cartSessionId,
  });

  int id;
  String name;
  String email;
  dynamic phone;
  String verified;
  String verificationToken;
  String phoneVerified;
  dynamic emailVerifiedAt;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic bannedAt;
  dynamic deactivatedAt;
  dynamic cartSessionId;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    verified: json["verified"],
    verificationToken: json["verification_token"],
    phoneVerified: json["phone_verified"],
    emailVerifiedAt: json["email_verified_at"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    bannedAt: json["banned_at"],
    deactivatedAt: json["deactivated_at"],
    cartSessionId: json["cart_session_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "verified": verified,
    "verification_token": verificationToken,
    "phone_verified": phoneVerified,
    "email_verified_at": emailVerifiedAt,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "banned_at": bannedAt,
    "deactivated_at": deactivatedAt,
    "cart_session_id": cartSessionId,
  };
}
