import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/Product/product_pagination_model.dart';
import 'package:zcart_seller/domain/app/product/create_product/manufacturer_id.dart';
import 'package:zcart_seller/domain/app/product/create_product/update_product_model.dart';

import '../../../domain/app/product/create_product/create_product_model.dart';
import '../../../domain/app/product/create_product/gtin_types_model.dart';
import '../../../domain/app/product/create_product/tag_list.dart';
import '../../../domain/app/product/i_product_repo.dart';

class ProductRepo extends IProductRepo {
  final cleanApi = CleanApi.instance;

  @override
  Future<Either<CleanFailure, ProductPaginationModel>> getProducts(
      {required int page}) {
    return cleanApi.get(
        failureHandler:
            <ProductModel>(int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'product', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'product',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'product',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'product', error: responseBody.toString()));
          }
        },
        fromData: ((json) => ProductPaginationModel.fromMap(json)),
        endPoint: 'products?page=$page');
  }

  @override
  Future<Either<CleanFailure, Unit>> deleteProduct(int productId) {
    return cleanApi.delete(
        failureHandler:
            <Unit>(int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'product', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'product',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'product',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'product', error: responseBody.toString()));
          }
        },
        body: null,
        fromData: (json) => unit,
        endPoint: 'product/$productId/trash');
  }

  @override
  Future<Either<CleanFailure, Unit>> updateProduct({
    required UpdateProductModel updateDetails,
  }) async {
    return cleanApi.put(
        failureHandler:
            <Unit>(int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'product', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'product',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'product',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'product', error: responseBody.toString()));
          }
        },
        fromData: (json) => unit,
        body: null,
        endPoint: updateDetails.endPoint);
  }

  @override
  Future<Either<CleanFailure, Unit>> createProduct(
      CreateProductModel body) async {
    return await cleanApi.post(
        failureHandler:
            <Unit>(int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'product', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'product',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'product',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'product', error: responseBody.toString()));
          }
        },
        fromData: (data) => unit,
        body: null,
        endPoint: body.endPoint);
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