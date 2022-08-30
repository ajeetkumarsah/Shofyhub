import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/catalog/atributes/atributes_state.dart';
import 'package:zcart_seller/domain/app/catalog/atributes/i_atributes_repo.dart';
import 'package:zcart_seller/infrastructure/app/catalog/atributes/atributes_repo.dart';

final atributesProvider =
    StateNotifierProvider<AtributesNotifier, AtributesState>((ref) {
  return AtributesNotifier(AtributesRepo());
});

class AtributesNotifier extends StateNotifier<AtributesState> {
  final IAtributesRepo atributesRepo;
  AtributesNotifier(this.atributesRepo) : super(AtributesState.init());
  getAtributes() async {
    state = state.copyWith(loading: true);
    final data = await atributesRepo.getAtributes();
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), atributes: r));
  }

  createAtributes(
      {required String name,
      required String attributeTypeId,
      required String categoriesIds,
      required String order}) async {
    state = state.copyWith(loading: true);
    final data = await atributesRepo.createAtributes(
        name: name,
        attributeTypeId: attributeTypeId,
        categoriesIds: categoriesIds,
        order: order);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    getAtributes();
  }

  updateAtributes(
      {required int attributeId,
      required String name,
      required String attributeTypeId,
      required String categoriesIds,
      required String order}) async {
    state = state.copyWith(loading: true);
    final data = await atributesRepo.updateAtributes(
        attributeId: attributeId,
        name: name,
        attributeTypeId: attributeTypeId,
        categoriesIds: categoriesIds,
        order: order);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    getAtributes();
  }

  trashAttributes({required int attributeId}) async {
    state = state.copyWith(loading: true);
    final data = await atributesRepo.trashAttributes(attributeId: attributeId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    getAtributes();
  }

  restoreAttributes({required int attributeId}) async {
    state = state.copyWith(loading: true);
    final data =
        await atributesRepo.restoreAttributes(attributeId: attributeId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    getAtributes();
  }

  deleteAttributes({required int attributeId}) async {
    state = state.copyWith(loading: true);
    final data = await atributesRepo.deleteAttributes(attributeId: attributeId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    getAtributes();
  }
}
