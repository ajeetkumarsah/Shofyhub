import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';
import 'package:alpesportif_seller/domain/app/dashboard/item_model.dart';
import 'package:alpesportif_seller/domain/app/dashboard/statistic_model.dart';
import 'package:alpesportif_seller/domain/app/order/order_model.dart';

class DashboardState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final StatisticModel statistics;
  final List<OrderModel> latestOrders;
  final List<ItemModel> topSellingItems;
  final List<ItemModel> outOfStockItems;
  const DashboardState({
    required this.loading,
    required this.failure,
    required this.statistics,
    required this.latestOrders,
    required this.topSellingItems,
    required this.outOfStockItems,
  });

  DashboardState copyWith({
    bool? loading,
    CleanFailure? failure,
    StatisticModel? statistics,
    List<OrderModel>? latestOrders,
    List<ItemModel>? topSellingItems,
    List<ItemModel>? outOfStockItems,
  }) {
    return DashboardState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      statistics: statistics ?? this.statistics,
      latestOrders: latestOrders ?? this.latestOrders,
      topSellingItems: topSellingItems ?? this.topSellingItems,
      outOfStockItems: outOfStockItems ?? this.outOfStockItems,
    );
  }

  @override
  List<Object> get props => [
        loading,
        failure,
        statistics,
        latestOrders,
        topSellingItems,
        outOfStockItems,
      ];

  factory DashboardState.init() => DashboardState(
        loading: false,
        failure: CleanFailure.none(),
        statistics: StatisticModel.init(),
        latestOrders: const [],
        topSellingItems: const [],
        outOfStockItems: const [],
      );
}
