import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'package:zcart_seller/domain/app/form/key_value_data.dart';

class KeyValueFormState extends Equatable {
  final IList<KeyValueData> dataList;
  final bool loading;
  final CleanFailure failure;
  const KeyValueFormState({
    required this.dataList,
    required this.loading,
    required this.failure,
  });

  KeyValueFormState copyWith({
    IList<KeyValueData>? dataList,
    bool? loading,
    CleanFailure? failure,
  }) {
    return KeyValueFormState(
      dataList: dataList ?? this.dataList,
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
    );
  }

  factory KeyValueFormState.init() => KeyValueFormState(
      dataList: const IListConst([]),
      loading: false,
      failure: CleanFailure.none());

  @override
  String toString() =>
      'KeyValueFormState(data: $dataList, loading: $loading, failure: $failure)';

  @override
  List<Object> get props => [dataList, loading, failure];
}
