import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:zcart_seller/domain/app/stocks/inventories/inventory_details_model/images_class.dart';
import 'package:zcart_seller/domain/app/stocks/inventories/inventory_details_model/product_class.dart';

class InventoryDetailsModel extends Equatable {
  final int id;
  final String sku;
  final String title;
  final String slug;
  final String condition;
  final int stockQuantity;
  final String salePrice;
  final int warehouseId;
  final int productId;
  final InventoryProductModel product;
  final String brand;
  final int supplierId;
  final String conditionNote;
  final String description;
  final List<String> keyFeatures;
  final String purchasePrice;
  final String offerPrice;
  final String offerStart;
  final String offerEnd;
  final String shippingWeight;
  final int minOrderQuantity;
  final dynamic linkedItems;
  final String metaTitle;
  final String metaDescription;
  final String inspectionStatus;
  final bool hasOffer;
  final bool freeShipping;
  final bool active;
  final List<ImagesModel> images;
  const InventoryDetailsModel({
    required this.id,
    required this.sku,
    required this.title,
    required this.slug,
    required this.condition,
    required this.stockQuantity,
    required this.salePrice,
    required this.warehouseId,
    required this.productId,
    required this.product,
    required this.brand,
    required this.supplierId,
    required this.conditionNote,
    required this.description,
    required this.keyFeatures,
    required this.purchasePrice,
    required this.offerPrice,
    required this.offerStart,
    required this.offerEnd,
    required this.shippingWeight,
    required this.minOrderQuantity,
    required this.linkedItems,
    required this.metaTitle,
    required this.metaDescription,
    required this.inspectionStatus,
    required this.hasOffer,
    required this.freeShipping,
    required this.active,
    required this.images,
  });

  InventoryDetailsModel copyWith({
    int? id,
    String? sku,
    String? title,
    String? slug,
    String? condition,
    int? stockQuantity,
    String? salePrice,
    int? warehouseId,
    int? productId,
    InventoryProductModel? product,
    String? brand,
    int? supplierId,
    String? conditionNote,
    String? description,
    List<String>? keyFeatures,
    String? purchasePrice,
    String? offerPrice,
    String? offerStart,
    String? offerEnd,
    String? shippingWeight,
    int? minOrderQuantity,
    dynamic linkedItems,
    String? metaTitle,
    String? metaDescription,
    String? inspectionStatus,
    bool? hasOffer,
    bool? freeShipping,
    bool? active,
    List<ImagesModel>? images,
  }) {
    return InventoryDetailsModel(
      id: id ?? this.id,
      sku: sku ?? this.sku,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      condition: condition ?? this.condition,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      salePrice: salePrice ?? this.salePrice,
      warehouseId: warehouseId ?? this.warehouseId,
      productId: productId ?? this.productId,
      product: product ?? this.product,
      brand: brand ?? this.brand,
      supplierId: supplierId ?? this.supplierId,
      conditionNote: conditionNote ?? this.conditionNote,
      description: description ?? this.description,
      keyFeatures: keyFeatures ?? this.keyFeatures,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      offerPrice: offerPrice ?? this.offerPrice,
      offerStart: offerStart ?? this.offerStart,
      offerEnd: offerEnd ?? this.offerEnd,
      shippingWeight: shippingWeight ?? this.shippingWeight,
      minOrderQuantity: minOrderQuantity ?? this.minOrderQuantity,
      linkedItems: linkedItems ?? this.linkedItems,
      metaTitle: metaTitle ?? this.metaTitle,
      metaDescription: metaDescription ?? this.metaDescription,
      inspectionStatus: inspectionStatus ?? this.inspectionStatus,
      hasOffer: hasOffer ?? this.hasOffer,
      freeShipping: freeShipping ?? this.freeShipping,
      active: active ?? this.active,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sku': sku,
      'title': title,
      'slug': slug,
      'condition': condition,
      'stock_quantity': stockQuantity,
      'sale_price': salePrice,
      'warehouse_id': warehouseId,
      'product_id': productId,
      'product': product.toMap(),
      'brand': brand,
      'supplier_id': supplierId,
      'condition_note': conditionNote,
      'description': description,
      'key_features': keyFeatures,
      'purchase_price': purchasePrice,
      'offer_price': offerPrice,
      'offer_start': offerStart,
      'offer_end': offerEnd,
      'shipping_weight': shippingWeight,
      'min_order_quantity': minOrderQuantity,
      'linked_items': linkedItems,
      'meta_title': metaTitle,
      'meta_description': metaDescription,
      'inspection_status': inspectionStatus,
      'has_offer': hasOffer,
      'free_shipping': freeShipping,
      'active': active,
      'images': images.map((x) => x.toMap()).toList(),
    };
  }

  factory InventoryDetailsModel.fromMap(Map<String, dynamic> map) {
    return InventoryDetailsModel(
      id: map['id']?.toInt() ?? 0,
      sku: map['sku'] ?? '',
      title: map['title'] ?? '',
      slug: map['slug'] ?? '',
      condition: map['condition'] ?? '',
      stockQuantity: map['stock_quantity']?.toInt() ?? 0,
      salePrice: map['sale_price'] ?? '',
      warehouseId: map['warehouse_id']?.toInt() ?? 0,
      productId: map['product_id']?.toInt() ?? 0,
      product: InventoryProductModel.fromMap(map['product']),
      brand: map['brand'] ?? '',
      supplierId: map['supplier_id']?.toInt() ?? 0,
      conditionNote: map['condition_note'] ?? '',
      description: map['description'] ?? '',
      keyFeatures: map['key_features'] != null
          ? List<String>.from(map['key_features']?.map((x) => x))
          : [],
      purchasePrice: map['purchase_price'] ?? '',
      offerPrice: map['offer_price'] ?? '',
      offerStart: map['offer_start'] ?? '',
      offerEnd: map['offer_end'] ?? '',
      shippingWeight: map['shipping_weight'] ?? '',
      minOrderQuantity: map['min_order_quantity']?.toInt() ?? 0,
      linkedItems: map['linked_items'],
      metaTitle: map['meta_title'] ?? '',
      metaDescription: map['meta_description'] ?? '',
      inspectionStatus: map['inspection_status'] ?? '',
      hasOffer: map['has_offer'] ?? false,
      freeShipping: map['free_shipping'] ?? false,
      active: map['active'] ?? false,
      images: List<ImagesModel>.from(
          map['images']?.map((x) => ImagesModel.fromMap(x)) ?? const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryDetailsModel.fromJson(String source) =>
      InventoryDetailsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InventoryDetailsModel(id: $id, sku: $sku, title: $title, slug: $slug, condition: $condition, stockQuantity: $stockQuantity, salePrice: $salePrice, warehouseId: $warehouseId, productId: $productId, product: $product, brand: $brand, supplierId: $supplierId, conditionNote: $conditionNote, description: $description, keyFeatures: $keyFeatures, purchasePrice: $purchasePrice, offerPrice: $offerPrice, offerStart: $offerStart, offerEnd: $offerEnd, shippingWeight: $shippingWeight, minOrderQuantity: $minOrderQuantity, linkedItems: $linkedItems, metaTitle: $metaTitle, metaDescription: $metaDescription, inspectionStatus: $inspectionStatus, hasOffer: $hasOffer, freeShipping: $freeShipping, active: $active, images: $images)';
  }

  @override
  List<Object> get props {
    return [
      id,
      sku,
      title,
      slug,
      condition,
      stockQuantity,
      salePrice,
      warehouseId,
      productId,
      product,
      brand,
      supplierId,
      conditionNote,
      description,
      keyFeatures,
      purchasePrice,
      offerPrice,
      offerStart,
      offerEnd,
      shippingWeight,
      minOrderQuantity,
      linkedItems,
      metaTitle,
      metaDescription,
      inspectionStatus,
      hasOffer,
      freeShipping,
      active,
      images,
    ];
  }

  factory InventoryDetailsModel.init() => InventoryDetailsModel(
        id: 0,
        sku: '',
        title: '',
        slug: '',
        condition: '',
        stockQuantity: 0,
        salePrice: '',
        warehouseId: 0,
        productId: 0,
        product: InventoryProductModel.init(),
        brand: '',
        supplierId: 0,
        conditionNote: '',
        description: '',
        keyFeatures: const [],
        purchasePrice: '',
        offerPrice: '',
        offerStart: '',
        offerEnd: '',
        shippingWeight: '',
        minOrderQuantity: 0,
        linkedItems: const [],
        metaTitle: '',
        metaDescription: '',
        inspectionStatus: '',
        hasOffer: false,
        freeShipping: false,
        active: false,
        images: const [],
      );
}
