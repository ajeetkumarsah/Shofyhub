import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/carriers/carrier_model.dart';

abstract class ICarrierRepo {
  Future<Either<CleanFailure, List<CarrierModel>>> getCarriers();
}
