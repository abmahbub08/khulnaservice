// To parse this JSON data, do
//
//     final profileDataModel = profileDataModelFromJson(jsonString);

import 'dart:convert';

ProfileDataModel profileDataModelFromJson(String str) =>
    ProfileDataModel.fromJson(json.decode(str));

String profileDataModelToJson(ProfileDataModel data) =>
    json.encode(data.toJson());

class ProfileDataModel {
  ProfileDataModel({
    this.user,
    this.primaryAddress,
    this.shippingAddress,
    this.billingAddress,
    this.divisions,
  });

  User user;
  Address primaryAddress;
  Address shippingAddress;
  Address billingAddress;
  List<State> divisions;

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) =>
      ProfileDataModel(
        user: User.fromJson(json["user"]),
        primaryAddress: json["primaryAddress"] != null
            ? Address.fromJson(json["primaryAddress"])
            : null,
        shippingAddress: json["shippingAddress"] != null
            ? Address.fromJson(json["shippingAddress"])
            : null,
        billingAddress: json["billingAddress"] != null
            ? Address.fromJson(json["billingAddress"])
            : null,
        divisions:
            List<State>.from(json["divisions"].map((x) => State.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "primaryAddress": primaryAddress.toJson(),
        "shippingAddress": shippingAddress.toJson(),
        "billingAddress": billingAddress.toJson(),
        "divisions": List<dynamic>.from(divisions.map((x) => x.toJson())),
      };
}

class Address {
  Address({
    this.id,
    this.modelId,
    this.modelType,
    this.addressType,
    this.phone,
    this.address1,
    this.address2,
    this.cityId,
    this.stateId,
    this.countryCode,
    this.createdAt,
    this.updatedAt,
    this.city,
    this.state,
    this.country,
  });

  int id;
  int modelId;
  String modelType;
  int addressType;
  String phone;
  String address1;
  String address2;
  int cityId;
  int stateId;
  String countryCode;
  DateTime createdAt;
  DateTime updatedAt;
  City city;
  State state;
  Country country;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        modelId: json["model_id"],
        modelType: json["model_type"],
        addressType: json["address_type"],
        phone: json["phone"],
        address1: json["address_1"],
        address2: json["address_2"],
        cityId: json["city_id"],
        stateId: json["state_id"],
        countryCode: json["country_code"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        city: City.fromJson(json["city"]),
        state: State.fromJson(json["state"]),
        country: Country.fromJson(json["country"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "model_id": modelId,
        "model_type": modelType,
        "address_type": addressType,
        "phone": phone,
        "address_1": address1,
        "address_2": address2,
        "city_id": cityId,
        "state_id": stateId,
        "country_code": countryCode,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "city": city.toJson(),
        "state": state.toJson(),
        "country": country.toJson(),
      };
}

class City {
  City({
    this.id,
    this.divisionId,
    this.name,
    this.bnName,
    this.lat,
    this.lon,
    this.website,
  });

  int id;
  int divisionId;
  String name;
  String bnName;
  double lat;
  double lon;
  String website;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        divisionId: json["division_id"],
        name: json["name"],
        bnName: json["bn_name"],
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        website: json["website"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "division_id": divisionId,
        "name": name,
        "bn_name": bnName,
        "lat": lat,
        "lon": lon,
        "website": website,
      };
}

class Country {
  Country({
    this.id,
    this.code,
    this.name,
  });

  int id;
  String code;
  String name;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        code: json["code"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
      };
}

class State {
  State({
    this.id,
    this.name,
    this.bnName,
    this.districts,
  });

  int id;
  String name;
  String bnName;
  List<City> districts;

  factory State.fromJson(Map<String, dynamic> json) => State(
        id: json["id"],
        name: json["name"],
        bnName: json["bn_name"],
        districts: json["districts"] == null
            ? null
            : List<City>.from(json["districts"].map((x) => City.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "bn_name": bnName,
        "districts": districts == null
            ? null
            : List<dynamic>.from(districts.map((x) => x.toJson())),
      };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.verified,
    this.verificationToken,
    this.phone,
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
  dynamic email;
  int verified;
  dynamic verificationToken;
  String phone;
  int phoneVerified;
  dynamic emailVerifiedAt;
  dynamic image;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic bannedAt;
  dynamic deactivatedAt;
  dynamic cartSessionId;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        verified: json["verified"],
        verificationToken: json["verification_token"],
        phone: json["phone"],
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
        "verified": verified,
        "verification_token": verificationToken,
        "phone": phone,
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
