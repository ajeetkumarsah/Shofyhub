import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/catalog/manufacturer/manufacturer_state.dart';
import 'package:zcart_seller/domain/app/catalog/manufacturer/i_manufacturer_repo.dart';
import 'package:zcart_seller/infrastructure/app/catalog/manufacturer/manufacturer_repo.dart';

final manufacturerProvider =
    StateNotifierProvider<ManufacturerNotifier, ManufacturerState>((ref) {
  return ManufacturerNotifier(ManufacturerRepo());
});

class ManufacturerNotifier extends StateNotifier<ManufacturerState> {
  final IManufacturerRepo manufacturerRepo;
  ManufacturerNotifier(this.manufacturerRepo) : super(ManufacturerState.init());

  getManufacturerList() async {
    state = state.copyWith(loading: true);
    final date = await manufacturerRepo.getManufacturerList();
    state = date.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), manufacturerList: r));
    Logger.i(state.manufacturerList);
  }

  createManufacturer(
      {required String name,
      required String slug,
      required String url,
      required bool active,
      required String countryId,
      required String email,
      required String phone,
      required String description}) async {
    state = state.copyWith(loading: true);
    final date = await manufacturerRepo.createManufacturer(
        name: name,
        slug: slug,
        url: url,
        active: active,
        countryId: countryId,
        email: email,
        phone: phone,
        description: description);
    state = date.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getManufacturerList();
  }

  updateManufacturer(
      {required int manufacturerId,
      required String name,
      required String slug,
      required String url,
      required bool active,
      required String countryId,
      required String email,
      required String phone,
      required String description}) async {
    state = state.copyWith(loading: true);
    final date = await manufacturerRepo.updateManufacturer(
        manufacturerId: manufacturerId,
        name: name,
        slug: slug,
        url: url,
        active: active,
        countryId: countryId,
        email: email,
        phone: phone,
        description: description);
    state = date.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getManufacturerList();
  }

  deleteManufacturer({required int manufacturerId}) async {
    final date = await manufacturerRepo.deleteManufacturer(
        manufacturerId: manufacturerId);
    state = date.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getManufacturerList();
  }

  restoreManufacturer({required int manufacturerId}) async {
    final date = await manufacturerRepo.restoreManufacturer(
        manufacturerId: manufacturerId);
    state = date.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getManufacturerList();
  }

  trashManufacturer({required int manufacturerId}) async {
    final date = await manufacturerRepo.trashManufacturer(
        manufacturerId: manufacturerId);
    state = date.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getManufacturerList();
  }
}
