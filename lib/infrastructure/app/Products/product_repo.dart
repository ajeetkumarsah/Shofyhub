import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/Product/create_product/manufacturer_id.dart';

import '../../../domain/app/Product/create_product/create_product_model.dart';
import '../../../domain/app/Product/create_product/gtin_types_model.dart';
import '../../../domain/app/Product/create_product/tag_list.dart';
import '../../../domain/app/Product/i_product_repo.dart';
import '../../../domain/app/Product/product_model.dart';

class ProductRepo extends IProductRepo {
  final cleanApi = CleanApi.instance;

  @override
  Future<Either<CleanFailure, List<ProductModel>>> getProducts() {
    return cleanApi.get(
        fromData: ((json) => List<ProductModel>.from(
            json['data'].map((e) => ProductModel.fromMap(e)))),
        endPoint: 'products');
  }

  @override
  Future<Either<CleanFailure, Unit>> deleteProduct(int productId) {
    return cleanApi.delete(
        body: null,
        fromData: (json) => unit,
        endPoint: 'product/$productId/trash');
  }

  @override
  Future<Either<CleanFailure, Unit>> updateProduct(
      {required CreateProductModel updateDetails,
      required int productId}) async {
    return cleanApi.get(
        fromData: (json) => unit,
        endPoint:
            'product/$productId/update?manufacturer_id=${updateDetails.manufacturerId}&brand=${updateDetails.brand}&name=${updateDetails.name}&model_number=${updateDetails.modeNumber}&mpn=${updateDetails.mpn}&gtin=${updateDetails.gtin}&gtin_type=${updateDetails.gtinType}&description=${updateDetails.description}&origin_country=${updateDetails.originCountry}&slug=${updateDetails.slug}&category_list[]=${updateDetails.categoryList}&active=${updateDetails.active}');
  }

  @override
  Future<Either<CleanFailure, Unit>> createProduct(
      CreateProductModel body) async {
    return await cleanApi.post(
        fromData: (data) => unit, body: null, endPoint: body.endPoint);
  }

  @override
  Future<Either<CleanFailure, List<GtinTypes>>> gtinType() async {
    return await cleanApi.get(
        fromData: (json) => List<GtinTypes>.from(json
            .map((key, value) =>
                MapEntry(key, GtinTypes(name: key, value: value)))
            .values),
        endPoint: 'data/gtin_type');
  }

  @override
  Future<Either<CleanFailure, List<TagListModel>>> tagList() async {
    return await cleanApi.get(
        fromData: (json) => List<TagListModel>.from(json
            .map((key, value) =>
                MapEntry(key, TagListModel(id: key, value: value)))
            .values),
        endPoint: 'data/tag_lists');
  }

  @override
  Future<Either<CleanFailure, List<ManufacturerId>>> manufacturer() async {
    return await cleanApi.get(
        fromData: (json) => List<ManufacturerId>.from(json
            .map((key, value) =>
                MapEntry(key, ManufacturerId(id: key, value: value)))
            .values),
        endPoint: 'data/manufacturers');
  }
}

// min_price=${updateDetails.minPrice}&max_price=${updateDetails.maxPrice}&
// &has_variant=${updateDetails.hasVariant}&downloadable=${updateDetails.downloadable}
// &sale_count=${updateDetails.saleCount}