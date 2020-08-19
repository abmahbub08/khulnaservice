// To parse this JSON data, do
//
//     final orderListModel = orderListModelFromJson(jsonString);

import 'dart:convert';

OrderListModel orderListModelFromJson(String str) =>
    OrderListModel.fromJson(json.decode(str));

String orderListModelToJson(OrderListModel data) => json.encode(data.toJson());

class OrderListModel {
  OrderListModel({
    this.orders,
  });

  List<Order> orders;

  factory OrderListModel.fromJson(Map<String, dynamic> json) => OrderListModel(
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
      };
}

class Order {
  Order({
    this.id,
    this.reference,
    this.paymentMethod,
    this.courierId,
    this.buyerId,
    this.billingAddressId,
    this.shippingAddressId,
    this.orderState,
    this.paymentState,
    this.currency,
    this.productTotal,
    this.tax,
    this.shipping,
    this.discount,
    this.discountCode,
    this.total,
    this.totalPaid,
    this.totalRefunded,
    this.commission,
    this.name,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.cart,
  });

  int id;
  dynamic reference;
  String paymentMethod;
  String courierId;
  String buyerId;
  String billingAddressId;
  String shippingAddressId;
  String orderState;
  String paymentState;
  String currency;
  String productTotal;
  String tax;
  String shipping;
  String discount;
  String discountCode;
  String total;
  String totalPaid;
  String totalRefunded;
  String commission;
  Name name;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  List<Cart> cart;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        reference: json["reference"],
        paymentMethod: json["payment_method"],
        courierId: json["courier_id"],
        buyerId: json["buyer_id"],
        billingAddressId: json["billing_address_id"],
        shippingAddressId: json["shipping_address_id"],
        orderState: json["order_state"],
        paymentState: json["payment_state"],
        currency: json["currency"] == null ? null : json["currency"],
        productTotal: json["product_total"],
        tax: json["tax"],
        shipping: json["shipping"],
        discount: json["discount"],
        discountCode: json["discount_code"],
        total: json["total"],
        totalPaid: json["total_paid"],
        totalRefunded: json["total_refunded"],
        commission: json["commission"],
        name: json["name"] == null ? null : nameValues.map[json["name"]],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        cart: List<Cart>.from(json["cart"].map((x) => Cart.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reference": reference,
        "payment_method": paymentMethod,
        "courier_id": courierId,
        "buyer_id": buyerId,
        "billing_address_id": billingAddressId,
        "shipping_address_id": shippingAddressId,
        "order_state": stateValues.reverse[orderState],
        "payment_state": stateValues.reverse[paymentState],
        "currency": currency == null ? null : currency,
        "product_total": productTotal,
        "tax": tax,
        "shipping": shipping,
        "discount": discount,
        "discount_code": discountCode,
        "total": total,
        "total_paid": totalPaid,
        "total_refunded": totalRefunded,
        "commission": commission,
        "name": name == null ? null : nameValues.reverse[name],
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
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
  dynamic quantity;
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
        "image": Image,
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

enum Image {
  MOSHUR_DAL_DESHI_1_KG_PNG,
  CINNAMON_JPG,
  LBP6030_B2_PNG,
  W_JPG,
  N_JPG,
  GURU_MUSIC_2_JPG
}

final imageValues = EnumValues({
  "cinnamon.jpg": Image.CINNAMON_JPG,
  "guru-music-2.jpg": Image.GURU_MUSIC_2_JPG,
  "lbp6030-b2.png": Image.LBP6030_B2_PNG,
  "moshur-dal-deshi-1-kg.png": Image.MOSHUR_DAL_DESHI_1_KG_PNG,
  "n.jpg": Image.N_JPG,
  "w.jpg": Image.W_JPG
});

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

enum Name { MASUM, BILLAH, DHDH }

final nameValues =
    EnumValues({"billah": Name.BILLAH, "dhdh": Name.DHDH, "masum": Name.MASUM});

enum State { PENDING, CANCELLED, COMPLETED }

final stateValues = EnumValues({
  "cancelled": State.CANCELLED,
  "completed": State.COMPLETED,
  "pending": State.PENDING
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
