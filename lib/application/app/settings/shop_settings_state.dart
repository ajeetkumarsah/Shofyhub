import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';
import 'package:zcart_seller/domain/app/settings/advance_shop_settings_model.dart';
import 'package:zcart_seller/domain/app/settings/basic_shop_settings_model.dart';

class ShopSettingsState extends Equatable {
  final bool loading;
  final bool loadingUpdate;
  final CleanFailure failure;
  final BasicShopSettingsModel basicShopSettings;
  final AdvanceShopSettingsModel advanceShopSettings;

  const ShopSettingsState({
    required this.loading,
    required this.loadingUpdate,
    required this.failure,
    required this.basicShopSettings,
    required this.advanceShopSettings,
  });

  ShopSettingsState copyWith({
    bool? loading,
    bool? loadingUpdate,
    CleanFailure? failure,
    BasicShopSettingsModel? basicShopSettings,
    AdvanceShopSettingsModel? advanceShopSettings,
  }) {
    return ShopSettingsState(
      loading: loading ?? this.loading,
      loadingUpdate: loadingUpdate ?? this.loadingUpdate,
      failure: failure ?? this.failure,
      basicShopSettings: basicShopSettings ?? this.basicShopSettings,
      advanceShopSettings: advanceShopSettings ?? this.advanceShopSettings,
    );
  }

  @override
  List<Object> get props {
    return [
      loading,
      loadingUpdate,
      failure,
      basicShopSettings,
    ];
  }

  factory ShopSettingsState.init() => ShopSettingsState(
        loading: false,
        loadingUpdate: false,
        failure: CleanFailure.none(),
        basicShopSettings: BasicShopSettingsModel.init(),
        advanceShopSettings: AdvanceShopSettingsModel.init(),
      );
}
