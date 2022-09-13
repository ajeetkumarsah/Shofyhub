import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/stocks/warehouse/warehouse_model.dart';

abstract class IWarehouseRepo {
  Future<Either<CleanFailure, List<WarehouseModel>>> getWarehouseItems();
}
