import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';
import 'package:alpesportif_seller/domain/app/settings/shop_config_model.dart';
import 'package:alpesportif_seller/domain/app/settings/shop_settings_model.dart';
import 'package:alpesportif_seller/domain/app/settings/system_config_model.dart';

class ShopSettingsState extends Equatable {
  final bool loading;
  final bool loadingUpdate;
  final CleanFailure failure;
  final ShopSettingsModel shopSettings;
  final ShopConfigModel shopConfigs;
  final SystemConfigModel systemConfigs;

  const ShopSettingsState({
    required this.loading,
    required this.loadingUpdate,
    required this.failure,
    required this.shopSettings,
    required this.shopConfigs,
    required this.systemConfigs,
  });

  ShopSettingsState copyWith({
    bool? loading,
    bool? loadingUpdate,
    CleanFailure? failure,
    ShopSettingsModel? shopSettings,
    ShopConfigModel? shopConfigs,
    SystemConfigModel? systemConfigs,
  }) {
    return ShopSettingsState(
      loading: loading ?? this.loading,
      loadingUpdate: loadingUpdate ?? this.loadingUpdate,
      failure: failure ?? this.failure,
      shopSettings: shopSettings ?? this.shopSettings,
      shopConfigs: shopConfigs ?? this.shopConfigs,
      systemConfigs: systemConfigs ?? this.systemConfigs,
    );
  }

  @override
  List<Object> get props {
    return [
      loading,
      loadingUpdate,
      failure,
      shopSettings,
      shopConfigs,
      systemConfigs,
    ];
  }

  factory ShopSettingsState.init() => ShopSettingsState(
      loading: false,
      loadingUpdate: false,
      failure: CleanFailure.none(),
      shopSettings: ShopSettingsModel.init(),
      shopConfigs: ShopConfigModel.init(),
      systemConfigs: SystemConfigModel.init());
}
