import 'package:clean_api/clean_api.dart';

import 'package:zcart_seller/domain/app/Product/product_model.dart';

import 'create_product/create_product_model.dart';

abstract class IProductRepo {
  Future<Either<CleanFailure, List<ProductModel>>> getProducts();
  Future<Either<CleanFailure, Unit>> deleteProduct(int productId);
  Future<Either<CleanFailure, Unit>> createProduct(CreateProductModel body);
  Future<Either<CleanFailure, Unit>> updateProduct(
      {required CreateProductModel updateDetails});
}
