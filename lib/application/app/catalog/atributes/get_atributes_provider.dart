import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/catalog/atributes/get_atributes_state.dart';
import 'package:zcart_seller/domain/app/catalog/atributes/i_atributes_repo.dart';
import 'package:zcart_seller/infrastructure/app/catalog/atributes/atributes_repo.dart';

final getAttributesProvider =
    StateNotifierProvider<GetAtributesNotifier, GetAtributesState>((ref) {
  return GetAtributesNotifier(AtributesRepo());
});

class GetAtributesNotifier extends StateNotifier<GetAtributesState> {
  final IAtributesRepo getAtributeRepo;

  GetAtributesNotifier(this.getAtributeRepo) : super(GetAtributesState.init());
  getAlAtributes({required int attributeId}) async {
    state = state.copyWith(loading: true);
    final data = await getAtributeRepo.getAlAtributes(attributeId: attributeId);
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), atributeId: r));
  }

  getAttributesTypes() async {
    state = state.copyWith(loading: true);
    final data = await getAtributeRepo.getAttributesTypes();
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), attributeType: r));
  }

  getCategories() async {
    state = state.copyWith(loading: true);
    final data = await getAtributeRepo.getCategories();
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), categories: r));
  }
}
