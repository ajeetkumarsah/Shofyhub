import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:zcart_seller/domain/app/shop/taxes/tax_model.dart';

class TaxState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final List<TaxModel> taxList;
  final TaxModel taxDetails;
  const TaxState({
    required this.loading,
    required this.failure,
    required this.taxList,
    required this.taxDetails,
  });

  TaxState copyWith({
    bool? loading,
    CleanFailure? failure,
    List<TaxModel>? taxList,
    TaxModel? taxDetails,
  }) {
    return TaxState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      taxList: taxList ?? this.taxList,
      taxDetails: taxDetails ?? this.taxDetails,
    );
  }

  @override
  String toString() {
    return 'TaxState(loading: $loading, failure: $failure, taxList: $taxList, taxDetails: $taxDetails)';
  }

  @override
  List<Object> get props => [loading, failure, taxList, taxDetails];

  factory TaxState.init() => TaxState(
        loading: false,
        failure: CleanFailure.none(),
        taxList: const [],
        taxDetails: TaxModel.init(),
      );
}
