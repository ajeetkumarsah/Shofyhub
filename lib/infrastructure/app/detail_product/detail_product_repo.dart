import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/product/detail_product/detail_product_model.dart';

import '../../../domain/app/product/detail_product/i_detail_product_repo.dart';

class DetailProductRepo extends IDetailProductRepo {
  final cleanApi = CleanApi.instance;

  @override
  Future<Either<CleanFailure, DetailProductModel>> getDetailProduct(
      {required int productId}) {
    return cleanApi.get(
        fromData: ((json) => DetailProductModel.fromMap(json['data'])),
        endPoint: 'product/$productId');
  }
}
