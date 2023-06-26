import 'dart:convert';

InventoryDetailsModel inventoryDetailsModelFromJson(String str) =>
    InventoryDetailsModel.fromJson(json.decode(str));

String inventoryDetailsModelToJson(InventoryDetailsModel data) =>
    json.encode(data.toJson());

class InventoryDetailsModel {
  Data? data;

  InventoryDetailsModel({
    this.data,
  });

  factory InventoryDetailsModel.fromJson(Map<String, dynamic> json) =>
      InventoryDetailsModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  int? id;
  String? sku;
  String? title;
  String? slug;
  String? condition;
  int? stockQuantity;
  String? salePrice;
  dynamic warehouseId;
  int? productId;
  Product? product;
  String? brand;
  int? supplierId;
  String? conditionNote;
  String? description;
  List<String>? keyFeatures;
  String? purchasePrice;
  dynamic offerPrice;
  dynamic offerStart;
  dynamic offerEnd;
  String? shippingWeight;
  int? minOrderQuantity;
  List<int>? linkedItems;
  String? metaTitle;
  String? metaDescription;
  dynamic inspectionStatus;
  bool? hasOffer;
  bool? freeShipping;
  bool? active;
  String? listedAt;
  List<Image>? images;

  Data({
    this.id,
    this.sku,
    this.title,
    this.slug,
    this.condition,
    this.stockQuantity,
    this.salePrice,
    this.warehouseId,
    this.productId,
    this.product,
    this.brand,
    this.supplierId,
    this.conditionNote,
    this.description,
    this.keyFeatures,
    this.purchasePrice,
    this.offerPrice,
    this.offerStart,
    this.offerEnd,
    this.shippingWeight,
    this.minOrderQuantity,
    this.linkedItems,
    this.metaTitle,
    this.metaDescription,
    this.inspectionStatus,
    this.hasOffer,
    this.freeShipping,
    this.active,
    this.listedAt,
    this.images,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        sku: json["sku"],
        title: json["title"],
        slug: json["slug"],
        condition: json["condition"],
        stockQuantity: json["stock_quantity"],
        salePrice: json["sale_price"],
        warehouseId: json["warehouse_id"],
        productId: json["product_id"],
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        brand: json["brand"],
        supplierId: json["supplier_id"],
        conditionNote: json["condition_note"],
        description: json["description"],
        keyFeatures: json["key_features"] == null
            ? []
            : List<String>.from(json["key_features"]!.map((x) => x)),
        purchasePrice: json["purchase_price"],
        offerPrice: json["offer_price"],
        offerStart: json["offer_start"],
        offerEnd: json["offer_end"],
        shippingWeight: json["shipping_weight"],
        minOrderQuantity: json["min_order_quantity"],
        linkedItems: json["linked_items"] == null
            ? []
            : List<int>.from(json["linked_items"]!.map((x) => x)),
        metaTitle: json["meta_title"],
        metaDescription: json["meta_description"],
        inspectionStatus: json["inspection_status"],
        hasOffer: json["has_offer"],
        freeShipping: json["free_shipping"],
        active: json["active"],
        listedAt: json["listed_at"],
        images: json["images"] == null
            ? []
            : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sku": sku,
        "title": title,
        "slug": slug,
        "condition": condition,
        "stock_quantity": stockQuantity,
        "sale_price": salePrice,
        "warehouse_id": warehouseId,
        "product_id": productId,
        "product": product?.toJson(),
        "brand": brand,
        "supplier_id": supplierId,
        "condition_note": conditionNote,
        "description": description,
        "key_features": keyFeatures == null
            ? []
            : List<dynamic>.from(keyFeatures!.map((x) => x)),
        "purchase_price": purchasePrice,
        "offer_price": offerPrice,
        "offer_start": offerStart,
        "offer_end": offerEnd,
        "shipping_weight": shippingWeight,
        "min_order_quantity": minOrderQuantity,
        "linked_items": linkedItems == null
            ? []
            : List<dynamic>.from(linkedItems!.map((x) => x)),
        "meta_title": metaTitle,
        "meta_description": metaDescription,
        "inspection_status": inspectionStatus,
        "has_offer": hasOffer,
        "free_shipping": freeShipping,
        "active": active,
        "listed_at": listedAt,
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
      };
}

class Image {
  int? id;
  String? path;
  String? name;
  String? extension;
  int? order;
  dynamic featured;

  Image({
    this.id,
    this.path,
    this.name,
    this.extension,
    this.order,
    this.featured,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        path: json["path"],
        name: json["name"],
        extension: json["extension"],
        order: json["order"],
        featured: json["featured"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "path": path,
        "name": name,
        "extension": extension,
        "order": order,
        "featured": featured,
      };
}

class Product {
  int? id;
  String? slug;
  String? name;
  Map<String, String>? categories;
  String? modelNumber;
  String? gtin;
  String? gtinType;
  String? mpn;
  String? brand;
  String? availableFrom;
  String? image;

  Product({
    this.id,
    this.slug,
    this.name,
    this.categories,
    this.modelNumber,
    this.gtin,
    this.gtinType,
    this.mpn,
    this.brand,
    this.availableFrom,
    this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        slug: json["slug"],
        name: json["name"],
        categories:
            json["categories"] == null || json["categories"].runtimeType != Map
                ? {}
                : Map.from(json["categories"]!)
                    .map((k, v) => MapEntry<String, String>(k, v)),
        modelNumber: json["model_number"],
        gtin: json["gtin"],
        gtinType: json["gtin_type"],
        mpn: json["mpn"],
        brand: json["brand"],
        availableFrom: json["available_from"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "name": name,
        "categories": Map.from(categories!)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "model_number": modelNumber,
        "gtin": gtin,
        "gtin_type": gtinType,
        "mpn": mpn,
        "brand": brand,
        "available_from": availableFrom,
        "image": image,
      };
}
