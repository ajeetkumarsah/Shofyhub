import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';
import 'package:zcart_seller/domain/app/support/live_chat/conversation_model.dart';

class ConversessionState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final List<ConversessionModel> conversessionList;
  final ConversessionModel conversessionDetails;
  const ConversessionState({
    required this.loading,
    required this.failure,
    required this.conversessionList,
    required this.conversessionDetails,
  });

  ConversessionState copyWith({
    bool? loading,
    CleanFailure? failure,
    List<ConversessionModel>? conversessionList,
    ConversessionModel? conversessionDetails,
  }) {
    return ConversessionState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      conversessionList: conversessionList ?? this.conversessionList,
      conversessionDetails: conversessionDetails ?? this.conversessionDetails,
    );
  }

  @override
  String toString() {
    return 'ConversessionState(loading: $loading, failure: $failure, conversessionList: $conversessionList, conversessionDetails: $conversessionDetails)';
  }

  @override
  List<Object> get props =>
      [loading, failure, conversessionList, conversessionDetails];

  factory ConversessionState.init() => ConversessionState(
        loading: false,
        failure: CleanFailure.none(),
        conversessionList: const [],
        conversessionDetails: ConversessionModel.init(),
      );
}
