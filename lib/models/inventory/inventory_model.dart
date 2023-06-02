import 'dart:convert';

InventoryModel inventoryModelFromJson(String str) =>
    InventoryModel.fromJson(json.decode(str));

String inventoryModelToJson(InventoryModel data) => json.encode(data.toJson());

class InventoryModel {
  List<Inventory>? data;
  Links? links;
  Meta? meta;

  InventoryModel({
    this.data,
    this.links,
    this.meta,
  });

  factory InventoryModel.fromJson(Map<String, dynamic> json) => InventoryModel(
        data: json["data"] == null
            ? []
            : List<Inventory>.from(
                json["data"]!.map((x) => Inventory.fromJson(x))),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "links": links?.toJson(),
        "meta": meta?.toJson(),
      };
}

class Inventory {
  int? id;
  String? sku;
  String? title;
  String? condition;
  int? stockQuantity;
  String? price;
  bool? hasOffer;
  String? offerPrice;
  bool? freeShipping;
  bool? active;
  int? shopId;
  String? image;

  Inventory({
    this.id,
    this.sku,
    this.title,
    this.condition,
    this.stockQuantity,
    this.price,
    this.hasOffer,
    this.offerPrice,
    this.freeShipping,
    this.active,
    this.shopId,
    this.image,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) => Inventory(
        id: json["id"],
        sku: json["sku"],
        title: json["title"],
        condition: json["condition"],
        stockQuantity: json["stock_quantity"],
        price: json["price"],
        hasOffer: json["has_offer"],
        offerPrice: json["offer_price"],
        freeShipping: json["free_shipping"],
        active: json["active"],
        shopId: json["shop_id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sku": sku,
        "title": title,
        "condition": condition,
        "stock_quantity": stockQuantity,
        "price": price,
        "has_offer": hasOffer,
        "offer_price": offerPrice,
        "free_shipping": freeShipping,
        "active": active,
        "shop_id": shopId,
        "image": image,
      };
}

class Links {
  String? first;
  String? last;
  dynamic prev;
  String? next;

  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<Link>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
