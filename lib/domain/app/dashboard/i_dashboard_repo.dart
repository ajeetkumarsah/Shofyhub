import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/dashboard/item_model.dart';
import 'package:zcart_seller/domain/app/dashboard/statistic_model.dart';
import 'package:zcart_seller/domain/app/order/order_model.dart';

abstract class IDashBoardRepo {
  Future<Either<CleanFailure, StatisticModel>> getStatistics();
  Future<Either<CleanFailure, List<OrderModel>>> getlatestOrders();
  Future<Either<CleanFailure, List<ItemModel>>> getTopSellingItems();
  Future<Either<CleanFailure, List<ItemModel>>> getOutOfStockItems();
}
