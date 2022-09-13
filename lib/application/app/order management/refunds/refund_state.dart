import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:zcart_seller/domain/app/order%20management/refund/refund_model.dart';

class RefundState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final List<RefundModel> openRefunds;
  final List<RefundModel> closedRefunds;
  final RefundModel refundDetails;
  const RefundState({
    required this.loading,
    required this.failure,
    required this.openRefunds,
    required this.closedRefunds,
    required this.refundDetails,
  });

  RefundState copyWith({
    bool? loading,
    CleanFailure? failure,
    List<RefundModel>? openRefunds,
    List<RefundModel>? closedRefunds,
    RefundModel? refundDetails,
  }) {
    return RefundState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      openRefunds: openRefunds ?? this.openRefunds,
      closedRefunds: closedRefunds ?? this.closedRefunds,
      refundDetails: refundDetails ?? this.refundDetails,
    );
  }

  @override
  String toString() {
    return 'RefundState(loading: $loading, failure: $failure, openRefunds: $openRefunds, closedRefunds: $closedRefunds, refundDetails: $refundDetails)';
  }

  @override
  List<Object> get props {
    return [
      loading,
      failure,
      openRefunds,
      closedRefunds,
      refundDetails,
    ];
  }

  factory RefundState.init() => RefundState(
      loading: false,
      failure: CleanFailure.none(),
      openRefunds: const [],
      closedRefunds: const [],
      refundDetails: RefundModel.init());
}
