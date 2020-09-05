// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    this.category,
  });

  List<Category> category;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category": List<dynamic>.from(category.map((x) => x.toJson())),
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
    this.children,
  });

  int id;
  String name;
  String slug;
  String description;
  dynamic image;
  dynamic backImage;
  int count;
  int state;
  int parentId;
  int position;
  int realDepth;
  int serial;
  int shipsInsideOnly;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  List<Category> children;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    description: json["description"] == null ? null : json["description"],
    image: json["image"],
    backImage: json["back_image"],
    count: json["count"],
    state: json["state"],
    parentId: json["parent_id"] == null ? null : json["parent_id"],
    position: json["position"],
    realDepth: json["real_depth"],
    serial: json["serial"] == null ? null : json["serial"],
    shipsInsideOnly: json["ships_inside_only"] == null ? null : json["ships_inside_only"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    children: List<Category>.from(json["children"].map((x) => Category.fromJson(x))),
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
    "parent_id": parentId == null ? null : parentId,
    "position": position,
    "real_depth": realDepth,
    "serial": serial == null ? null : serial,
    "ships_inside_only": shipsInsideOnly == null ? null : shipsInsideOnly,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "children": List<dynamic>.from(children.map((x) => x.toJson())),
  };
}
