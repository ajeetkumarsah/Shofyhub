import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/catalog/manufacturer/manufacturer_details_state.dart';
import 'package:zcart_seller/domain/app/catalog/manufacturer/i_manufacturer_repo.dart';
import 'package:zcart_seller/infrastructure/app/catalog/manufacturer/manufacturer_repo.dart';

final manufacturerDetailsProvider = StateNotifierProvider.family<
    ManufacturerDetailsNotifier,
    ManufacturerDetailsState,
    int>((ref, manufacturerId) {
  return ManufacturerDetailsNotifier(manufacturerId, ManufacturerRepo());
});

class ManufacturerDetailsNotifier
    extends StateNotifier<ManufacturerDetailsState> {
  final int manufacturerId;
  final IManufacturerRepo manufacturerRepo;
  ManufacturerDetailsNotifier(this.manufacturerId, this.manufacturerRepo)
      : super(ManufacturerDetailsState.init());

  getManufacturerDetails() async {
    state = state.copyWith(loading: true);
    final date = await manufacturerRepo.getManufacturerDetails(
        manufacturerId: manufacturerId);
    state = date.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false,
            failure: CleanFailure.none(),
            manufacturerDetails: r));
    Logger.i(state.manufacturerDetails);
  }
}
