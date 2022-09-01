import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class KeyValueData extends Equatable {
  final String key;
  final String value;
  const KeyValueData({
    required this.key,
    required this.value,
  });

  KeyValueData copyWith({
    String? key,
    String? value,
  }) {
    return KeyValueData(
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'value': value,
    };
  }

  factory KeyValueData.fromMap(Map<String, dynamic> map) {
    return KeyValueData(
      key: map['key'] ?? '',
      value: map['value'] ?? '',
    );
  }

  static IList<KeyValueData> listFromMap(Map<String, dynamic> map) {
    return map
        .map(
            (key, value) => MapEntry(key, KeyValueData(key: key, value: value)))
        .values
        .toIList();
  }

  String toJson() => json.encode(toMap());

  factory KeyValueData.fromJson(String source) =>
      KeyValueData.fromMap(json.decode(source));

  @override
  String toString() => 'KeyValueData(key: $key, value: $value)';

  @override
  List<Object> get props => [key, value];
}
