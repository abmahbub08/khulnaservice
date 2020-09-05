// To parse this JSON data, do
//
//     final homePageDataModel = homePageDataModelFromJson(jsonString);

import 'dart:convert';

HomePageDataModel homePageDataModelFromJson(String str) => HomePageDataModel.fromJson(json.decode(str));

String homePageDataModelToJson(HomePageDataModel data) => json.encode(data.toJson());

class HomePageDataModel {
  HomePageDataModel({
    this.headerKey,
    this.ecommerceSetting,
    this.featuredCategories,
    this.featuredProducts,
    this.homeCategories,
  });

  Map<String, String> headerKey;
  EcommerceSetting ecommerceSetting;
  List<Category> featuredCategories;
  List<Product> featuredProducts;
  List<Category> homeCategories;

  factory HomePageDataModel.fromJson(Map<String, dynamic> json) => HomePageDataModel(
    headerKey: Map.from(json["header_key"]).map((k, v) => MapEntry<String, String>(k, v)),
    ecommerceSetting: EcommerceSetting.fromJson(json["ecommerceSetting"]),
    featuredCategories: List<Category>.from(json["featuredCategories"].map((x) => Category.fromJson(x))),
    featuredProducts: List<Product>.from(json["featuredProducts"].map((x) => Product.fromJson(x))),
    homeCategories: List<Category>.from(json["homeCategories"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "header_key": Map.from(headerKey).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "ecommerceSetting": ecommerceSetting.toJson(),
    "featuredCategories": List<dynamic>.from(featuredCategories.map((x) => x.toJson())),
    "featuredProducts": List<dynamic>.from(featuredProducts.map((x) => x.toJson())),
    "homeCategories": List<dynamic>.from(homeCategories.map((x) => x.toJson())),
  };
}

class EcommerceSetting {
  EcommerceSetting({
    this.id,
    this.name,
    this.slug,
    this.createdAt,
    this.updatedAt,
    this.general,
    this.ecommerceBanner1,
    this.ecommerceBanner2,
    this.ecommerceGalleryImage1,
    this.banner1,
    this.banner2,
    this.seo,
    this.productFeatures,
    this.banner3,
    this.headerGalleryImage56657110C74311E98B354B1Bdbeace00,
    this.headerGalleryImage251Bbb20C74411E9B81299C7Ee3F3018,
    this.headerGalleryImageAf5515D0856811Ea85291Ddc8140Fc5C,
    this.metaKeys,
  });

  int id;
  String name;
  String slug;
  DateTime createdAt;
  DateTime updatedAt;
  General general;
  Banner1 ecommerceBanner1;
  Banner1 ecommerceBanner2;
  EcommerceGalleryImage1 ecommerceGalleryImage1;
  Banner1 banner1;
  Banner1 banner2;
  Seo seo;
  Map<String, ProductFeature> productFeatures;
  Banner1 banner3;
  Banner1 headerGalleryImage56657110C74311E98B354B1Bdbeace00;
  Banner1 headerGalleryImage251Bbb20C74411E9B81299C7Ee3F3018;
  Banner1 headerGalleryImageAf5515D0856811Ea85291Ddc8140Fc5C;
  List<String> metaKeys;

  factory EcommerceSetting.fromJson(Map<String, dynamic> json) => EcommerceSetting(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    general: General.fromJson(json["general"]),
    ecommerceBanner1: Banner1.fromJson(json["ecommerce_banner_1"]),
    ecommerceBanner2: Banner1.fromJson(json["ecommerce_banner_2"]),
    ecommerceGalleryImage1: EcommerceGalleryImage1.fromJson(json["ecommerce_gallery_image_1"]),
    banner1: Banner1.fromJson(json["banner_1"]),
    banner2: Banner1.fromJson(json["banner_2"]),
    seo: Seo.fromJson(json["seo"]),
    productFeatures: Map.from(json["product_features"]).map((k, v) => MapEntry<String, ProductFeature>(k, ProductFeature.fromJson(v))),
    banner3: Banner1.fromJson(json["banner_3"]),
    headerGalleryImage56657110C74311E98B354B1Bdbeace00: Banner1.fromJson(json["header_gallery_image_56657110-c743-11e9-8b35-4b1bdbeace00"]),
    headerGalleryImage251Bbb20C74411E9B81299C7Ee3F3018: Banner1.fromJson(json["header_gallery_image_251bbb20-c744-11e9-b812-99c7ee3f3018"]),
    headerGalleryImageAf5515D0856811Ea85291Ddc8140Fc5C: Banner1.fromJson(json["header_gallery_image_af5515d0-8568-11ea-8529-1ddc8140fc5c"]),
    metaKeys: List<String>.from(json["meta_keys"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "general": general.toJson(),
    "ecommerce_banner_1": ecommerceBanner1.toJson(),
    "ecommerce_banner_2": ecommerceBanner2.toJson(),
    "ecommerce_gallery_image_1": ecommerceGalleryImage1.toJson(),
    "banner_1": banner1.toJson(),
    "banner_2": banner2.toJson(),
    "seo": seo.toJson(),
    "product_features": Map.from(productFeatures).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "banner_3": banner3.toJson(),
    "header_gallery_image_56657110-c743-11e9-8b35-4b1bdbeace00": headerGalleryImage56657110C74311E98B354B1Bdbeace00.toJson(),
    "header_gallery_image_251bbb20-c744-11e9-b812-99c7ee3f3018": headerGalleryImage251Bbb20C74411E9B81299C7Ee3F3018.toJson(),
    "header_gallery_image_af5515d0-8568-11ea-8529-1ddc8140fc5c": headerGalleryImageAf5515D0856811Ea85291Ddc8140Fc5C.toJson(),
    "meta_keys": List<dynamic>.from(metaKeys.map((x) => x)),
  };
}

class Banner1 {
  Banner1({
    this.link,
    this.caption,
    this.image,
    this.show,
  });

  String link;
  String caption;
  String image;
  String show;

  factory Banner1.fromJson(Map<String, dynamic> json) => Banner1(
    link: json["link"] == null ? null : json["link"],
    caption: json["caption"] == null ? null : json["caption"],
    image: json["image"],
    show: json["show"] == null ? null : json["show"],
  );

  Map<String, dynamic> toJson() => {
    "link": link == null ? null : link,
    "caption": caption == null ? null : caption,
    "image": image,
    "show": show == null ? null : show,
  };
}

class EcommerceGalleryImage1 {
  EcommerceGalleryImage1({
    this.show,
    this.link,
    this.caption,
    this.image,
  });

  String show;
  String link;
  String caption;
  Image image;

  factory EcommerceGalleryImage1.fromJson(Map<String, dynamic> json) => EcommerceGalleryImage1(
    show: json["show"],
    link: json["link"],
    caption: json["caption"],
    image: Image.fromJson(json["image"]),
  );

  Map<String, dynamic> toJson() => {
    "show": show,
    "link": link,
    "caption": caption,
    "image": image.toJson(),
  };
}

class Image {
  Image();

  factory Image.fromJson(Map<String, dynamic> json) => Image(
  );

  Map<String, dynamic> toJson() => {
  };
}

class General {
  General({
    this.discountedShippingThreshold,
    this.corporateShippingThreshold,
    this.featuredCategories,
    this.homeCategories,
    this.homeCategoriesIdSerial,
  });

  String discountedShippingThreshold;
  String corporateShippingThreshold;
  List<String> featuredCategories;
  List<String> homeCategories;
  Map<String, String> homeCategoriesIdSerial;

  factory General.fromJson(Map<String, dynamic> json) => General(
    discountedShippingThreshold: json["discounted_shipping_threshold"],
    corporateShippingThreshold: json["corporate_shipping_threshold"],
    featuredCategories: List<String>.from(json["featured_categories"].map((x) => x)),
    homeCategories: List<String>.from(json["home_categories"].map((x) => x)),
    homeCategoriesIdSerial: Map.from(json["home_categories_id_serial"]).map((k, v) => MapEntry<String, String>(k, v)),
  );

  Map<String, dynamic> toJson() => {
    "discounted_shipping_threshold": discountedShippingThreshold,
    "corporate_shipping_threshold": corporateShippingThreshold,
    "featured_categories": List<dynamic>.from(featuredCategories.map((x) => x)),
    "home_categories": List<dynamic>.from(homeCategories.map((x) => x)),
    "home_categories_id_serial": Map.from(homeCategoriesIdSerial).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}

class ProductFeature {
  ProductFeature({
    this.name,
    this.icon,
    this.link,
  });

  String name;
  String icon;
  dynamic link;

  factory ProductFeature.fromJson(Map<String, dynamic> json) => ProductFeature(
    name: json["name"],
    icon: json["icon"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "icon": icon,
    "link": link,
  };
}

class Seo {
  Seo({
    this.title,
    this.keywords,
    this.description,
  });

  String title;
  String keywords;
  String description;

  factory Seo.fromJson(Map<String, dynamic> json) => Seo(
    title: json["title"],
    keywords: json["keywords"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "keywords": keywords,
    "description": description,
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
    this.products,
  });

  int id;
  String name;
  String slug;
  String description;
  dynamic image;
  dynamic backImage;
  int count;
  int state;
  dynamic parentId;
  int position;
  int realDepth;
  int serial;
  int shipsInsideOnly;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  List<Product> products;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    description: json["description"] == null ? null : json["description"],
    image: json["image"],
    backImage: json["back_image"],
    count: json["count"],
    state: json["state"],
    parentId: json["parent_id"],
    position: json["position"],
    realDepth: json["real_depth"],
    serial: json["serial"],
    shipsInsideOnly: json["ships_inside_only"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "description": description == null ? null : description,
    "image": image,
    "back_image": backImage,
    "count": count,
    "state": state,
    "parent_id": parentId,
    "position": position,
    "real_depth": realDepth,
    "serial": serial,
    "ships_inside_only": shipsInsideOnly,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
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
  int storeId;
  int manufacturerId;
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
  int state;
  int featured;
  int taxFree;
  String vat;
  String shipping;
  String commission;
  int stock;
  int variationCount;
  int visited;
  int decorationState;
  dynamic bannedAt;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic commentStats;

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
    shipping: json["shipping"] == null ? null : json["shipping"],
    commission: json["commission"],
    stock: json["stock"],
    variationCount: json["variation_count"],
    visited: json["visited"],
    decorationState: json["decoration_state"],
    bannedAt: json["banned_at"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    commentStats: json["comment_stats"],
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
    "shipping": shipping == null ? null : shipping,
    "commission": commission,
    "stock": stock,
    "variation_count": variationCount,
    "visited": visited,
    "decoration_state": decorationState,
    "banned_at": bannedAt,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "comment_stats": commentStats,
  };
}
