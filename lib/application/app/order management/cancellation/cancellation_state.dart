import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';
import 'package:zcart_seller/domain/app/order%20management/cancellation/cancellation_model.dart';

class CancellationState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final List<CancellationModel> allCancellations;
  final CancellationModel cancellationDetails;
  const CancellationState({
    required this.loading,
    required this.failure,
    required this.allCancellations,
    required this.cancellationDetails,
  });

  CancellationState copyWith({
    bool? loading,
    CleanFailure? failure,
    List<CancellationModel>? allCancellations,
    CancellationModel? cancellationDetails,
  }) {
    return CancellationState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      allCancellations: allCancellations ?? this.allCancellations,
      cancellationDetails: cancellationDetails ?? this.cancellationDetails,
    );
  }

  @override
  List<Object> get props {
    return [
      loading,
      failure,
      allCancellations,
      cancellationDetails,
    ];
  }

  factory CancellationState.init() => CancellationState(
      loading: false,
      failure: CleanFailure.none(),
      allCancellations: const [],
      cancellationDetails: CancellationModel.init());
}
