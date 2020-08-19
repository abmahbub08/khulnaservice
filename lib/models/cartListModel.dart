import 'dart:convert';

CartListModel cartListModelFromJson(String str) =>
    CartListModel.fromJson(json.decode(str));

String cartListModelToJson(CartListModel data) => json.encode(data.toJson());

class CartListModel {
  CartListModel({
    this.cart,
  });

  List<Cart> cart;

  factory CartListModel.fromJson(Map<String, dynamic> json) => CartListModel(
        cart: List<Cart>.from(json["cart"].map((x) => Cart.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cart": List<dynamic>.from(cart.map((x) => x.toJson())),
      };
}

class Cart {
  Cart({
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
  var quantity;
  Attributes attributes;
  List<Condition> conditions;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
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
  double commission;
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
        commission: json["commission"].toDouble(),
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
