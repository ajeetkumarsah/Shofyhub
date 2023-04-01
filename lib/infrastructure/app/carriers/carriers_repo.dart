import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/carriers/carrier_model.dart';
import 'package:zcart_seller/domain/app/carriers/i_carrier_repo.dart';

class CarriersRepo extends ICarrierRepo {
  final cleanApi = CleanApi.instance;
  @override
  Future<Either<CleanFailure, List<CarrierModel>>> getCarriers() async {
    return cleanApi.get(
      fromData: ((json) => List<CarrierModel>.from(
          json['data'].map((e) => CarrierModel.fromMap(e)))),
      endPoint: 'carriers',
    );
  }
}
