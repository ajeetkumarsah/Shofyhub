import 'dart:convert';

import 'package:equatable/equatable.dart';

class StatisticModel extends Equatable {
  final int latestOrderCount;
  final int unfulfilledOrderCount;
  final int todaysOrderCount;
  final int stockCount;
  final int stockOutCount;
  final String lastSaleAmount;
  final String todaysSaleAmount;
  final String yesterdaysSaleAmount;
  final String latestRefundAmount;

  const StatisticModel({
    required this.latestOrderCount,
    required this.unfulfilledOrderCount,
    required this.todaysOrderCount,
    required this.stockCount,
    required this.stockOutCount,
    required this.lastSaleAmount,
    required this.todaysSaleAmount,
    required this.yesterdaysSaleAmount,
    required this.latestRefundAmount,
  });

  StatisticModel copyWith({
    int? latestOrderCount,
    int? unfulfilledOrderCount,
    int? todaysOrderCount,
    int? stockCount,
    int? stockOutCount,
    String? lastSaleAmount,
    String? todaysSaleAmount,
    String? yesterdaysSaleAmount,
    String? latestRefundAmount,
  }) {
    return StatisticModel(
      latestOrderCount: latestOrderCount ?? this.latestOrderCount,
      unfulfilledOrderCount:
          unfulfilledOrderCount ?? this.unfulfilledOrderCount,
      todaysOrderCount: todaysOrderCount ?? this.todaysOrderCount,
      stockCount: stockCount ?? this.stockCount,
      stockOutCount: stockOutCount ?? this.stockOutCount,
      lastSaleAmount: lastSaleAmount ?? this.lastSaleAmount,
      todaysSaleAmount: todaysSaleAmount ?? this.todaysSaleAmount,
      yesterdaysSaleAmount: yesterdaysSaleAmount ?? this.yesterdaysSaleAmount,
      latestRefundAmount: latestRefundAmount ?? this.latestRefundAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latest_order_count': latestOrderCount,
      'unfulfilled_order_count': unfulfilledOrderCount,
      'todays_order_count': todaysOrderCount,
      'stock_count': stockCount,
      'stock_out_count': stockOutCount,
      'last_sale_amount': lastSaleAmount,
      'todays_sale_amount': todaysSaleAmount,
      'yesterdays_sale_amount': yesterdaysSaleAmount,
      'latest_refund_amount': latestRefundAmount,
    };
  }

  factory StatisticModel.fromMap(Map<String, dynamic> map) {
    return StatisticModel(
      latestOrderCount: map['latest_order_count']?.toInt() ?? 0,
      unfulfilledOrderCount: map['unfulfilled_order_count']?.toInt() ?? 0,
      todaysOrderCount: map['todays_order_count']?.toInt() ?? 0,
      stockCount: map['stock_count']?.toInt() ?? 0,
      stockOutCount: map['stock_out_count']?.toInt() ?? 0,
      lastSaleAmount: map['last_sale_amount'] ?? '',
      todaysSaleAmount: map['todays_sale_amount'] ?? '',
      yesterdaysSaleAmount: map['yesterdays_sale_amount'] ?? '',
      latestRefundAmount: map['latest_refund_amount'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StatisticModel.fromJson(String source) =>
      StatisticModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  String toString() {
    return 'StatisticModel(latestOrderCount: $latestOrderCount, unfulfilledOrderCount: $unfulfilledOrderCount, todaysOrderCount: $todaysOrderCount, stockCount: $stockCount, stockOutCount: $stockOutCount, lastSaleAmount: $lastSaleAmount, todaysSaleAmount: $todaysSaleAmount, yesterdaysSaleAmount: $yesterdaysSaleAmount, latestRefundAmount: $latestRefundAmount)';
  }

  @override
  List<Object?> get props => [
        latestOrderCount,
        unfulfilledOrderCount,
        todaysOrderCount,
        stockCount,
        stockOutCount,
        lastSaleAmount,
        todaysSaleAmount,
        yesterdaysSaleAmount,
        latestRefundAmount
      ];

  factory StatisticModel.init() => const StatisticModel(
        latestOrderCount: 1,
        unfulfilledOrderCount: 1,
        todaysOrderCount: 1,
        stockCount: 1,
        stockOutCount: 1,
        lastSaleAmount: '0',
        todaysSaleAmount: '0',
        yesterdaysSaleAmount: '0',
        latestRefundAmount: '0',
      );
}
