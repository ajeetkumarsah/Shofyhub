import 'package:clean_api/clean_api.dart';
import 'package:alpesportif_seller/domain/app/product/detail_product/detail_product_model.dart';

abstract class IDetailProductRepo {
  Future<Either<CleanFailure, DetailProductModel>> getDetailProduct(
      {required int productId});
}
