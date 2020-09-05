// To parse this JSON data, do
//
//     final orderListModel = orderListModelFromJson(jsondynamic);

import 'dart:convert';

OrderListModel orderListModelFromJson(dynamic str) => OrderListModel.fromJson(json.decode(str));

dynamic orderListModelToJson(OrderListModel data) => json.encode(data.toJson());

class OrderListModel {
  OrderListModel({
    this.orders,
  });

  List<Order> orders;

  factory OrderListModel.fromJson(Map<dynamic, dynamic> json) => OrderListModel(
    orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
  );

  Map<dynamic, dynamic> toJson() => {
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

  dynamic id;
  dynamic reference;
  dynamic paymentMethod;
  dynamic courierId;
  dynamic buyerId;
  dynamic billingAddressId;
  dynamic shippingAddressId;
  dynamic orderState;
  dynamic paymentState;
  dynamic currency;
  dynamic productTotal;
  dynamic tax;
  dynamic shipping;
  dynamic discount;
  dynamic discountCode;
  dynamic total;
  dynamic totalPaid;
  dynamic totalRefunded;
  dynamic commission;
  dynamic name;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  List<Cart> cart;

  factory Order.fromJson(Map<dynamic, dynamic> json) => Order(
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
    name: json["name"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    cart: List<Cart>.from(json["cart"].map((x) => Cart.fromJson(x))),
  );

  Map<dynamic, dynamic> toJson() => {
    "id": id,
    "reference": reference,
    "payment_method": paymentMethod,
    "courier_id": courierId,
    "buyer_id": buyerId,
    "billing_address_id": billingAddressId,
    "shipping_address_id": shippingAddressId,
    "order_state": orderState,
    "payment_state": paymentState,
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
    "name": name,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
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

  dynamic id;
  dynamic name;
  dynamic price;
  dynamic quantity;
  Attributes attributes;
  List<Condition> conditions;

  factory Cart.fromJson(Map<dynamic, dynamic> json) => Cart(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    quantity: json["quantity"],
    attributes: Attributes.fromJson(json["attributes"]),
    conditions: List<Condition>.from(json["conditions"].map((x) => Condition.fromJson(x))),
  );

  Map<dynamic, dynamic> toJson() => {
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

  dynamic image;
  dynamic storeId;
  dynamic shipping;
  dynamic vat;
  dynamic commission;
  List<dynamic> categoryIds;
  dynamic shipsInsideOnly;
  dynamic price;
  dynamic discountedPrice;
  dynamic discount;
  dynamic cartTs;

  factory Attributes.fromJson(Map<dynamic, dynamic> json) => Attributes(
    image: json["image"],
    storeId: json["store_id"],
    shipping: json["shipping"] == null ? null : json["shipping"],
    vat: json["vat"],
    commission: json["commission"].toDouble(),
    categoryIds: List<int>.from(json["category_ids"].map((x) => x)),
    shipsInsideOnly: json["ships_inside_only"],
    price: json["price"],
    discountedPrice: json["discounted_price"],
    discount: json["discount"],
    cartTs: json["cart_ts"],
  );

  Map<dynamic, dynamic> toJson() => {
    "image": image,
    "store_id": storeId,
    "shipping": shipping == null ? null : shipping,
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

  factory Condition.fromJson(Map<dynamic, dynamic> json) => Condition(
    parsedRawValue: json["parsedRawValue"],
  );

  Map<dynamic, dynamic> toJson() => {
    "parsedRawValue": parsedRawValue,
  };
}
