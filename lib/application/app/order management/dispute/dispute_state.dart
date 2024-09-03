import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';
import 'package:alpesportif_seller/domain/app/order%20management/dispute/dispute_details_model.dart';
import 'package:alpesportif_seller/domain/app/order%20management/dispute/dispute_mode.dart';

class DisputeState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final List<DisputeModel> allDisputes;
  final DisputeDetailsModel disputeDetails;
  const DisputeState({
    required this.loading,
    required this.failure,
    required this.allDisputes,
    required this.disputeDetails,
  });

  DisputeState copyWith({
    bool? loading,
    CleanFailure? failure,
    List<DisputeModel>? allDisputes,
    DisputeDetailsModel? disputeDetails,
  }) {
    return DisputeState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      allDisputes: allDisputes ?? this.allDisputes,
      disputeDetails: disputeDetails ?? this.disputeDetails,
    );
  }

  @override
  List<Object> get props {
    return [
      loading,
      failure,
      allDisputes,
      disputeDetails,
    ];
  }

  factory DisputeState.init() => DisputeState(
      loading: false,
      failure: CleanFailure.none(),
      allDisputes: const [],
      disputeDetails: DisputeDetailsModel.init());
}
