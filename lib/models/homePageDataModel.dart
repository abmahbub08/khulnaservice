import 'dart:convert';

HomePageDataModel homePageDataModelFromJson(String str) => HomePageDataModel.fromJson(json.decode(str));

String homePageDataModelToJson(HomePageDataModel data) => json.encode(data.toJson());

class HomePageDataModel {
  HomePageDataModel({
    this.featuredProducts,
    this.homeCategories,
  });

  List<Product> featuredProducts;
  List<HomeCategory> homeCategories;

  factory HomePageDataModel.fromJson(Map<String, dynamic> json) => HomePageDataModel(
    featuredProducts: List<Product>.from(json["featuredProducts"].map((x) => Product.fromJson(x))),
    homeCategories: List<HomeCategory>.from(json["homeCategories"].map((x) => HomeCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "featuredProducts": List<dynamic>.from(featuredProducts.map((x) => x.toJson())),
    "homeCategories": List<dynamic>.from(homeCategories.map((x) => x.toJson())),
  };
}

class Product {
  Product({
    this.id,
    this.storeId,
    this.manufacturerId,
    this.sku,
    this.name,
    this.description,
    this.features,
    this.productFeatures,
    this.returnPolicy,
    this.image,
    this.backImage,
    this.price,
    this.discountedPrice,
    this.state,
    this.featured,
    this.taxFree,
    this.vat,
    this.shipping,
    this.commission,
    this.stock,
    this.variationCount,
    this.visited,
    this.decorationState,
    this.bannedAt,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.commentStats,
  });

  int id;
  String storeId;
  String manufacturerId;
  String sku;
  String name;
  String description;
  String features;
  dynamic productFeatures;
  String returnPolicy;
  String image;
  String backImage;
  String price;
  String discountedPrice;
  String state;
  String featured;
  String taxFree;
  String vat;
  String shipping;
  String commission;
  String stock;
  String variationCount;
  String visited;
  String decorationState;
  dynamic bannedAt;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  CommentStats commentStats;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    storeId: json["store_id"],
    manufacturerId: json["manufacturer_id"],
    sku: json["sku"] == null ? null : json["sku"],
    name: json["name"],
    description: json["description"],
    features: json["features"],
    productFeatures: json["product_features"],
    returnPolicy: json["return_policy"],
    image: json["image"],
    backImage: json["back_image"],
    price: json["price"],
    discountedPrice: json["discounted_price"],
    state: json["state"],
    featured: json["featured"],
    taxFree: json["tax_free"],
    vat: json["vat"] == null ? null : json["vat"],
    shipping: json["shipping"],
    commission: json["commission"],
    stock: json["stock"],
    variationCount: json["variation_count"],
    visited: json["visited"],
    decorationState: json["decoration_state"],
    bannedAt: json["banned_at"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    commentStats: json["comment_stats"] == null ? null : CommentStats.fromJson(json["comment_stats"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "store_id": storeId,
    "manufacturer_id": manufacturerId,
    "sku": sku == null ? null : sku,
    "name": name,
    "description": description,
    "features": features,
    "product_features": productFeatures,
    "return_policy": returnPolicy,
    "image": image,
    "back_image": backImage,
    "price": price,
    "discounted_price": discountedPrice,
    "state": state,
    "featured": featured,
    "tax_free": taxFree,
    "vat": vat == null ? null : vat,
    "shipping": shipping,
    "commission": commission,
    "stock": stock,
    "variation_count": variationCount,
    "visited": visited,
    "decoration_state": decorationState,
    "banned_at": bannedAt,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "comment_stats": commentStats == null ? null : commentStats.toJson(),
  };
}

class CommentStats {
  CommentStats({
    this.commentableId,
    this.totalComments,
    this.averageRating,
  });

  String commentableId;
  String totalComments;
  String averageRating;

  factory CommentStats.fromJson(Map<String, dynamic> json) => CommentStats(
    commentableId: json["commentable_id"],
    totalComments: json["totalComments"],
    averageRating: json["averageRating"],
  );

  Map<String, dynamic> toJson() => {
    "commentable_id": commentableId,
    "totalComments": totalComments,
    "averageRating": averageRating,
  };
}

class HomeCategory {
  HomeCategory({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.image,
    this.backImage,
    this.count,
    this.state,
    this.parentId,
    this.position,
    this.realDepth,
    this.serial,
    this.shipsInsideOnly,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.products,
  });

  int id;
  String name;
  String slug;
  String description;
  String image;
  dynamic backImage;
  String count;
  String state;
  dynamic parentId;
  String position;
  String realDepth;
  String serial;
  String shipsInsideOnly;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  List<Product> products;

  factory HomeCategory.fromJson(Map<String, dynamic> json) => HomeCategory(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    description: json["description"],
    image: json["image"] == null ? null : json["image"],
    backImage: json["back_image"],
    count: json["count"],
    state: json["state"],
    parentId: json["parent_id"],
    position: json["position"],
    realDepth: json["real_depth"],
    serial: json["serial"],
    shipsInsideOnly: json["ships_inside_only"] == null ? null : json["ships_inside_only"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "description": description,
    "image": image == null ? null : image,
    "back_image": backImage,
    "count": count,
    "state": state,
    "parent_id": parentId,
    "position": position,
    "real_depth": realDepth,
    "serial": serial,
    "ships_inside_only": shipsInsideOnly == null ? null : shipsInsideOnly,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}
