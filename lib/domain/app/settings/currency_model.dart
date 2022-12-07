import 'package:equatable/equatable.dart';

class CurrencyModel extends Equatable {
  final String name;
  final String isoCode;
  final String symbol;
  final bool symbolFirst;
  final String subunit;
  final String decimalMark;
  final String thousandsSeparator;

  const CurrencyModel({
    required this.name,
    required this.isoCode,
    required this.symbol,
    required this.symbolFirst,
    required this.subunit,
    required this.decimalMark,
    required this.thousandsSeparator,
  });

  CurrencyModel copyWith({
    String? name,
    String? isoCode,
    String? symbol,
    bool? symbolFirst,
    String? subunit,
    String? decimalMark,
    String? thousandsSeparator,
  }) {
    return CurrencyModel(
      name: name ?? this.name,
      isoCode: isoCode ?? this.isoCode,
      symbol: symbol ?? this.symbol,
      symbolFirst: symbolFirst ?? this.symbolFirst,
      subunit: subunit ?? this.subunit,
      decimalMark: decimalMark ?? this.decimalMark,
      thousandsSeparator: thousandsSeparator ?? this.thousandsSeparator,
    );
  }

  factory CurrencyModel.fromMap(Map<String, dynamic> map) => CurrencyModel(
        name: map["name"] ?? '',
        isoCode: map["iso_code"] ?? '',
        symbol: map["symbol"] ?? '',
        symbolFirst: map["symbol_first"] ?? false,
        subunit: map["subunit"] ?? '',
        decimalMark: map["decimal_mark"] ?? '',
        thousandsSeparator: map["thousands_separator"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "iso_code": isoCode,
        "symbol": symbol,
        "symbol_first": symbolFirst,
        "subunit": subunit,
        "decimal_mark": decimalMark,
        "thousands_separator": thousandsSeparator,
      };

  factory CurrencyModel.init() => const CurrencyModel(
        name: '',
        isoCode: '',
        symbol: '',
        symbolFirst: false,
        subunit: '',
        decimalMark: '',
        thousandsSeparator: '',
      );

  @override
  List<Object?> get props => [
        name,
        isoCode,
        symbol,
        symbolFirst,
        subunit,
        decimalMark,
        thousandsSeparator,
      ];
}
