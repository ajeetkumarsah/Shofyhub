import 'package:clean_api/clean_api.dart';

import '../../../domain/app/Product/create_product/create_product_model.dart';
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
      {required CreateProductModel updateDetails}) async {
    return cleanApi.get(
        fromData: (json) => unit,
        endPoint:
            'product/create?manufacturer_id=${updateDetails.manufacturerId}&brand=${updateDetails.brand}&name=${updateDetails.name}&model_number=${updateDetails.modeNumber}&mpn=${updateDetails.mpn}&gtin=${updateDetails.gtin}&gtin_type=${updateDetails.gtinType}&description=${updateDetails.description}&min_price=${updateDetails.minPrice}&max_price=${updateDetails.maxPrice}&origin_country=${updateDetails.originCountry}&has_variant=${updateDetails.hasVariant}&downloadable=${updateDetails.downloadable}&slug=${updateDetails.slug}&sale_count=${updateDetails.saleCount}&category_list[]=${updateDetails.categoryList}&active=${updateDetails.active}');
  }

  @override
  Future<Either<CleanFailure, Unit>> createProduct(
      CreateProductModel body) async {
    return await cleanApi.post(
        fromData: (data) => unit, body: null, endPoint: body.endPoint);
  }
}
