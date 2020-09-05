// To parse this JSON data, do
//
//     final placeOrderModel = placeOrderModelFromJson(jsonString);

import 'dart:convert';

PlaceOrderModel placeOrderModelFromJson(String str) =>
    PlaceOrderModel.fromJson(json.decode(str));

String placeOrderModelToJson(PlaceOrderModel data) =>
    json.encode(data.toJson());

class PlaceOrderModel {
  PlaceOrderModel({
    this.cartItems,
    this.shippingAddress,
    this.billingAddress,
    this.shippingCondition,
    this.couponCondition,
    this.total,
    this.divisions,
  });

  List<CartItem> cartItems;
  IngAddress shippingAddress;
  IngAddress billingAddress;
  String shippingCondition;
  dynamic couponCondition;
  String total;
  List<State> divisions;

  factory PlaceOrderModel.fromJson(Map<String, dynamic> json) =>
      PlaceOrderModel(
        cartItems: List<CartItem>.from(
            json["cartItems"].map((x) => CartItem.fromJson(x))),
        shippingAddress: json["shippingAddress"] != null
            ? IngAddress.fromJson(json["shippingAddress"])
            : null,
        billingAddress: json["billingAddress"] != null
            ? IngAddress.fromJson(json["billingAddress"])
            : null,
        shippingCondition: json["shippingCondition"],
        couponCondition: json["couponCondition"],
        total: json["total"],
        divisions:
            List<State>.from(json["divisions"].map((x) => State.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cartItems": List<dynamic>.from(cartItems.map((x) => x.toJson())),
        "shippingAddress": shippingAddress.toJson(),
        "billingAddress": billingAddress.toJson(),
        "shippingCondition": shippingCondition,
        "couponCondition": couponCondition,
        "total": total,
        "divisions": List<dynamic>.from(divisions.map((x) => x.toJson())),
      };
}

class IngAddress {
  IngAddress({
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

  factory IngAddress.fromJson(Map<String, dynamic> json) => IngAddress(
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

class CartItem {
  CartItem({
    this.id,
    this.name,
    this.price,
    this.quantity,
    this.attributes,
    this.conditions,
  });

  int id;
  String name;
  int price;
  String quantity;
  Attributes attributes;
  List<Condition> conditions;

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        quantity: json["quantity"],
        attributes: Attributes.fromJson(json["attributes"]),
        conditions: List<Condition>.from(
            json["conditions"].map((x) => Condition.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "quantity": quantity,
        "attributes": attributes.toJson(),
        "conditions": List<dynamic>.from(conditions.map((x) => x.toJson())),
      };
}

class Attributes {
  Attributes({
    this.image,
    this.storeId,
    this.shipping,
    this.vat,
    this.commission,
    this.categoryIds,
    this.shipsInsideOnly,
    this.price,
    this.discountedPrice,
    this.discount,
    this.cartTs,
  });

  String image;
  int storeId;
  String shipping;
  int vat;
  dynamic commission;
  List<int> categoryIds;
  int shipsInsideOnly;
  String price;
  String discountedPrice;
  int discount;
  int cartTs;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        image: json["image"],
        storeId: json["store_id"],
        shipping: json["shipping"],
        vat: json["vat"],
        commission: json["commission"],
        categoryIds: List<int>.from(json["category_ids"].map((x) => x)),
        shipsInsideOnly: json["ships_inside_only"],
        price: json["price"],
        discountedPrice: json["discounted_price"],
        discount: json["discount"],
        cartTs: json["cart_ts"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "store_id": storeId,
        "shipping": shipping,
        "vat": vat,
        "commission": commission,
        "category_ids": List<dynamic>.from(categoryIds.map((x) => x)),
        "ships_inside_only": shipsInsideOnly,
        "price": price,
        "discounted_price": discountedPrice,
        "discount": discount,
        "cart_ts": cartTs,
      };
}

class Condition {
  Condition({
    this.parsedRawValue,
  });

  dynamic parsedRawValue;

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        parsedRawValue: json["parsedRawValue"],
      );

  Map<String, dynamic> toJson() => {
        "parsedRawValue": parsedRawValue,
      };
}
