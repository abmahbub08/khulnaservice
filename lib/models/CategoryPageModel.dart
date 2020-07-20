import 'dart:convert';

CategoryPageModel categoryPageModelFromJson(String str) => CategoryPageModel.fromJson(json.decode(str));

String categoryPageModelToJson(CategoryPageModel data) => json.encode(data.toJson());

class CategoryPageModel {
  CategoryPageModel({
    this.category,
    this.products,
    this.manufacturers,
    this.ancestors,
    this.descendants,
  });

  Category category;
  Products products;
  List<Manufacturer> manufacturers;
  List<Category> ancestors;
  List<dynamic> descendants;

  factory CategoryPageModel.fromJson(Map<String, dynamic> json) => CategoryPageModel(
    category: Category.fromJson(json["category"]),
    products: Products.fromJson(json["products"]),
    manufacturers: List<Manufacturer>.from(json["manufacturers"].map((x) => Manufacturer.fromJson(x))),
    ancestors: List<Category>.from(json["ancestors"].map((x) => Category.fromJson(x))),
    descendants: List<dynamic>.from(json["descendants"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "category": category.toJson(),
    "products": products.toJson(),
    "manufacturers": List<dynamic>.from(manufacturers.map((x) => x.toJson())),
    "ancestors": List<dynamic>.from(ancestors.map((x) => x.toJson())),
    "descendants": List<dynamic>.from(descendants.map((x) => x)),
  };
}

class Category {
  Category({
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
    this.closureId,
    this.ancestor,
    this.descendant,
    this.depth,
    this.pivot,
  });

  int id;
  Name name;
  Slug slug;
  Description description;
  dynamic image;
  dynamic backImage;
  String count;
  String state;
  String parentId;
  String position;
  String realDepth;
  String serial;
  String shipsInsideOnly;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String closureId;
  String ancestor;
  String descendant;
  String depth;
  Pivot pivot;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: nameValues.map[json["name"]],
    slug: slugValues.map[json["slug"]],
    description: descriptionValues.map[json["description"]],
    image: json["image"],
    backImage: json["back_image"],
    count: json["count"],
    state: json["state"],
    parentId: json["parent_id"] == null ? null : json["parent_id"],
    position: json["position"],
    realDepth: json["real_depth"],
    serial: json["serial"],
    shipsInsideOnly: json["ships_inside_only"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    closureId: json["closure_id"] == null ? null : json["closure_id"],
    ancestor: json["ancestor"] == null ? null : json["ancestor"],
    descendant: json["descendant"] == null ? null : json["descendant"],
    depth: json["depth"] == null ? null : json["depth"],
    pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": nameValues.reverse[name],
    "slug": slugValues.reverse[slug],
    "description": descriptionValues.reverse[description],
    "image": image,
    "back_image": backImage,
    "count": count,
    "state": state,
    "parent_id": parentId == null ? null : parentId,
    "position": position,
    "real_depth": realDepth,
    "serial": serial,
    "ships_inside_only": shipsInsideOnly,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "closure_id": closureId == null ? null : closureId,
    "ancestor": ancestor == null ? null : ancestor,
    "descendant": descendant == null ? null : descendant,
    "depth": depth == null ? null : depth,
    "pivot": pivot == null ? null : pivot.toJson(),
  };
}

enum Description { ALL_KINDS_OF_BEAUTY_HEALTH, L_KIND_OF_BATH_ITEM }

final descriptionValues = EnumValues({
  "All kinds of Beauty & Health": Description.ALL_KINDS_OF_BEAUTY_HEALTH,
  "l kind of Bath item": Description.L_KIND_OF_BATH_ITEM
});

enum Name { BEAUTY_HEALTH, BATH_BODY }

final nameValues = EnumValues({
  "Bath & Body": Name.BATH_BODY,
  "Beauty & Health": Name.BEAUTY_HEALTH
});

class Pivot {
  Pivot({
    this.productId,
    this.categoryId,
  });

  String productId;
  String categoryId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    productId: json["product_id"],
    categoryId: json["category_id"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "category_id": categoryId,
  };
}

enum Slug { BEAUTY_HEALTH, BATH_BODY }

final slugValues = EnumValues({
  "bath-body": Slug.BATH_BODY,
  "beauty-health": Slug.BEAUTY_HEALTH
});

class Manufacturer {
  Manufacturer({
    this.id,
    this.name,
    this.description,
    this.image,
    this.count,
    this.state,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String description;
  dynamic image;
  String count;
  String state;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory Manufacturer.fromJson(Map<String, dynamic> json) => Manufacturer(
    id: json["id"],
    name: json["name"],
    description: json["description"] == null ? null : json["description"],
    image: json["image"],
    count: json["count"],
    state: json["state"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description == null ? null : description,
    "image": image,
    "count": count,
    "state": state,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Products {
  Products({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    currentPage: json["current_page"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Datum {
  Datum({
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
    this.categories,
    this.manufacturer,
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
  List<Category> categories;
  Manufacturer manufacturer;
  dynamic commentStats;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    storeId: json["store_id"],
    manufacturerId: json["manufacturer_id"],
    sku: json["sku"],
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
    vat: json["vat"],
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
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    manufacturer: Manufacturer.fromJson(json["manufacturer"]),
    commentStats: json["comment_stats"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "store_id": storeId,
    "manufacturer_id": manufacturerId,
    "sku": sku,
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
    "vat": vat,
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
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    "manufacturer": manufacturer.toJson(),
    "comment_stats": commentStats,
  };
}

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
