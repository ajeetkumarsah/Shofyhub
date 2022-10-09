import 'package:equatable/equatable.dart';

class ItemModel extends Equatable {
  final int id;
  final String sku;
  final String title;
  final int productId;
  final String soldQtt;
  final int stockQuantity;
  final String price;
  final String grossSales;
  final bool active;
  final String image;

  const ItemModel({
    required this.id,
    required this.sku,
    required this.title,
    required this.productId,
    required this.soldQtt,
    required this.stockQuantity,
    required this.price,
    required this.grossSales,
    required this.active,
    required this.image,
  });

  ItemModel copyWith({
    int? id,
    String? sku,
    String? title,
    int? productId,
    String? soldQtt,
    int? stockQuantity,
    String? price,
    String? grossSales,
    bool? active,
    String? image,
  }) {
    return ItemModel(
      id: id ?? this.id,
      sku: sku ?? this.sku,
      title: title ?? this.title,
      productId: productId ?? this.productId,
      soldQtt: soldQtt ?? this.soldQtt,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      price: price ?? this.price,
      grossSales: grossSales ?? this.grossSales,
      active: active ?? this.active,
      image: image ?? this.image,
    );
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'sku': sku,
  //     'title': title,
  //     'model_number': modelNumber,
  //     'gtin': gtin,
  //     'gtin_type': gtinType,
  //     'mpn': mpn,
  //     'brand': brand,
  //     'available_from': availableFrom,
  //     'image': image,
  //   };
  // }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id']?.toInt() ?? 0,
      sku: map['sku'] ?? '',
      title: map['title'] ?? '',
      productId: map['product_id']?.toInt() ?? 0,
      soldQtt: map['sold_qtt'] ?? '',
      stockQuantity: map['stock_quantity']?.toInt() ?? 0,
      price: map['price'] ?? '',
      grossSales: map['gross_sales'] ?? '',
      active: map['active'] ?? false,
      image: map['image'] ?? '',
    );
  }

  // String toJson() => json.encode(toMap());

  // factory ItemModel.fromJson(String source) =>
  //     ItemModel.fromMap(json.decode(source));

  // @override
  // String toString() {
  //   return 'ItemModel(id: $id, sku: $sku, title: $title, modelNumber: $modelNumber, gtin: $gtin, gtinType: $gtinType, mpn: $mpn, brand: $brand, availableFrom: $availableFrom, image: $image)';
  // }

  @override
  List<Object> get props {
    return [
      id,
      sku,
      title,
      productId,
      soldQtt,
      stockQuantity,
      price,
      grossSales,
      active,
      image,
    ];
  }
}
