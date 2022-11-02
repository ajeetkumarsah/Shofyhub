import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/catalog/manufacturer/manufacturer_state.dart';
import 'package:zcart_seller/domain/app/catalog/manufacturer/i_manufacturer_repo.dart';
import 'package:zcart_seller/domain/app/catalog/manufacturer/manufacturer_model.dart';
import 'package:zcart_seller/domain/app/catalog/manufacturer/manufacturer_pagination_model.dart';
import 'package:zcart_seller/infrastructure/app/catalog/manufacturer/manufacturer_repo.dart';

final manufacturerProvider =
    StateNotifierProvider<ManufacturerNotifier, ManufacturerState>((ref) {
  return ManufacturerNotifier(ManufacturerRepo());
});

class ManufacturerNotifier extends StateNotifier<ManufacturerState> {
  final IManufacturerRepo manufacturerRepo;
  ManufacturerNotifier(this.manufacturerRepo) : super(ManufacturerState.init());

  ManufacturerPaginationModel manufacturerPaginationModel =
      ManufacturerPaginationModel.init();
  List<ManufacturerModel> manufactureres = [];
  int pageNumber = 1;

  List<ManufacturerModel> trashManufactureres = [];
  int trashPageNumber = 1;

  getManufacturerList() async {
    pageNumber = 1;
    manufactureres = [];

    state = state.copyWith(loading: true);
    final data = await manufacturerRepo.getManufacturerList(
        filter: 'null', page: pageNumber);

    //increase the page no
    pageNumber++;

    state = data.fold((l) => state.copyWith(loading: false, failure: l), (r) {
      manufacturerPaginationModel = r;
      manufactureres.addAll(manufacturerPaginationModel.data);

      return state.copyWith(
        loading: false,
        manufacturerList: manufactureres,
        failure: CleanFailure.none(),
      );
    });
    Logger.i(state.manufacturerList);
  }

  getMoreManufacturerList() async {
    if (pageNumber == 1 ||
        pageNumber <= manufacturerPaginationModel.meta.lastPage!) {
      final data = await manufacturerRepo.getManufacturerList(
          filter: 'null', page: pageNumber);

      //increase the page no
      pageNumber++;

      state = data.fold((l) => state.copyWith(loading: false, failure: l), (r) {
        manufacturerPaginationModel = r;
        manufactureres.addAll(manufacturerPaginationModel.data);

        return state.copyWith(
          loading: false,
          manufacturerList: manufactureres,
          failure: CleanFailure.none(),
        );
      });
      Logger.i(state.manufacturerList);
    }
  }

  getTrashManufacturerList() async {
    pageNumber = 1;
    manufactureres = [];

    state = state.copyWith(loading: true);
    final data = await manufacturerRepo.getManufacturerList(
        filter: 'trash', page: pageNumber);

    //increase the page no
    pageNumber++;

    state = data.fold((l) => state.copyWith(loading: false, failure: l), (r) {
      manufacturerPaginationModel = r;
      manufactureres.addAll(manufacturerPaginationModel.data);

      return state.copyWith(
        loading: false,
        manufacturerList: manufactureres,
        failure: CleanFailure.none(),
      );
    });
    Logger.i(state.manufacturerList);
  }

  getMoreTrashManufacturerList() async {
    if (pageNumber == 1 ||
        pageNumber <= manufacturerPaginationModel.meta.lastPage!) {
      final data = await manufacturerRepo.getManufacturerList(
          filter: 'trash', page: pageNumber);

      //increase the page no
      pageNumber++;

      state = data.fold((l) => state.copyWith(loading: false, failure: l), (r) {
        manufacturerPaginationModel = r;
        manufactureres.addAll(manufacturerPaginationModel.data);

        return state.copyWith(
          loading: false,
          manufacturerList: manufactureres,
          failure: CleanFailure.none(),
        );
      });
      Logger.i(state.manufacturerList);
    }
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
    state = state.copyWith(loading: true);
    final date = await manufacturerRepo.deleteManufacturer(
        manufacturerId: manufacturerId);
    state = date.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getManufacturerList();
    getTrashManufacturerList();
  }

  restoreManufacturer({required int manufacturerId}) async {
    state = state.copyWith(loading: true);
    final date = await manufacturerRepo.restoreManufacturer(
        manufacturerId: manufacturerId);
    state = date.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getManufacturerList();
    getTrashManufacturerList();
  }

  trashManufacturer({required int manufacturerId}) async {
    state = state.copyWith(loading: true);
    final date = await manufacturerRepo.trashManufacturer(
        manufacturerId: manufacturerId);
    state = date.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getManufacturerList();
    getTrashManufacturerList();
  }
}
