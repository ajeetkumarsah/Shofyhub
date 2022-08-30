// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:zcart_seller/domain/app/catalog/attribute%20values/attribute_value_details_model/attribute_value_details_model.dart';

class AttributeValueDetalsState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final AttributeValueDetailsModel attributeValueDetails;
  const AttributeValueDetalsState({
    required this.loading,
    required this.failure,
    required this.attributeValueDetails,
  });

  AttributeValueDetalsState copyWith({
    bool? loading,
    CleanFailure? failure,
    AttributeValueDetailsModel? attributeValueDetails,
  }) {
    return AttributeValueDetalsState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      attributeValueDetails:
          attributeValueDetails ?? this.attributeValueDetails,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [loading, failure, attributeValueDetails];

  factory AttributeValueDetalsState.init() => AttributeValueDetalsState(
      loading: false,
      failure: CleanFailure.none(),
      attributeValueDetails: AttributeValueDetailsModel.init());
}
