import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/Product/Detail%20Product/detail_product_model.dart';

abstract class IDetailProductRepo {
  Future<Either<CleanFailure, DetailProductModel>> getDetailProduct(
      {required DetailProductModel productId});
}
