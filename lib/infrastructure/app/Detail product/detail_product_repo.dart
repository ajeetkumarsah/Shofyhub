import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/Product/Detail%20Product/detail_product_model.dart';

import '../../../domain/app/Product/Detail Product/i_detail_product_repo.dart';

class DetailProductRepo extends IDetailProductRepo {
  final cleanApi = CleanApi.instance;

  @override
  Future<Either<CleanFailure, DetailProductModel>> getDetailProduct(
      {required DetailProductModel productId}) {
    return cleanApi.get(
        fromData: ((json) => DetailProductModel.fromMap(
            json['data'].map((e) => DetailProductModel.fromMap(e)))),
        endPoint: 'product/$productId');
  }
}
