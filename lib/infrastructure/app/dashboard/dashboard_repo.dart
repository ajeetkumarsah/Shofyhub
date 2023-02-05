import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/dashboard/i_dashboard_repo.dart';
import 'package:zcart_seller/domain/app/order/order_model.dart';
import 'package:zcart_seller/domain/app/dashboard/statistic_model.dart';
import 'package:zcart_seller/domain/app/dashboard/item_model.dart';

class DashboardRepo extends IDashBoardRepo {
  final cleanApi = CleanApi.instance;

  @override
  Future<Either<CleanFailure, List<ItemModel>>> getOutOfStockItems() {
    return cleanApi.get(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'outOfStock', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'outOfStock',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'outOfStock',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(CleanFailure(
                tag: 'outOfStock', error: responseBody.toString()));
          }
        },
        fromData: ((json) => List<ItemModel>.from(
            json['data'].map((e) => ItemModel.fromMap(e)))),
        endPoint: 'inventories/out_of_stocks?limit=5');
  }

  @override
  Future<Either<CleanFailure, StatisticModel>> getStatistics() {
    return cleanApi.get(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'statistics', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'statistics',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'statistics',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(CleanFailure(
                tag: 'statistics', error: responseBody.toString()));
          }
        },
        fromData: ((json) => StatisticModel.fromMap(json['data'])),
        endPoint: 'statistics/basic?latest_in_days=15');
  }

  @override
  Future<Either<CleanFailure, List<ItemModel>>> getTopSellingItems() {
    return cleanApi.get(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(
                CleanFailure(tag: 'topSellingItem', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'topSellingItem',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'topSellingItem',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(CleanFailure(
                tag: 'topSellingItem', error: responseBody.toString()));
          }
        },
        fromData: ((json) => List<ItemModel>.from(
            json['data'].map((e) => ItemModel.fromMap(e)))),
        endPoint: 'inventories/top_selling?limit=5');
  }

  @override
  Future<Either<CleanFailure, List<OrderModel>>> getlatestOrders() {
    return cleanApi.get(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'latesOrder', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'latesOrder',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'latesOrder',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(CleanFailure(
                tag: 'topSellingItem', error: responseBody.toString()));
          }
        },
        fromData: ((json) => List<OrderModel>.from(
            json['data'].map((e) => OrderModel.fromMap(e)))),
        endPoint: 'latest_orders');
  }
}
