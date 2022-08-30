import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/catalog/attribute%20values/attribute_values_state.dart';
import 'package:zcart_seller/domain/app/catalog/attribute%20values/i_attribute_values_repo.dart';
import 'package:zcart_seller/infrastructure/app/catalog/attribute%20values/attribute_values_repo.dart';

final attributeValuesProvider = StateNotifierProvider.family
    .autoDispose<AttributeValuesNotifier, AttributeValuesState, int>((ref, id) {
  return AttributeValuesNotifier(id, AttributeValuesRepo());
});

class AttributeValuesNotifier extends StateNotifier<AttributeValuesState> {
  final int id;
  final IAttributeValuesRepo attributeValuesRepo;
  AttributeValuesNotifier(this.id, this.attributeValuesRepo)
      : super(AttributeValuesState.init());

  getAttributeValues() async {
    state = state.copyWith(loading: true);
    final data = await attributeValuesRepo.getAttributeValues(attributeId: id);
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), attributeValues: r));
    Logger.i(data);
  }

  createAttributeValue(
      String value, int attributeId, String color, int order) async {
    state = state.copyWith(loading: true);
    final data = await attributeValuesRepo.createAttributeValue(
        value: value, attributeId: attributeId, color: color, order: order);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    getAttributeValues();
  }

  updateAttributeValue(
      {required int attributeValueId,
      required String value,
      required String color,
      required int attributeId,
      required int order}) async {
    state = state.copyWith(loading: true);
    final data = await attributeValuesRepo.updateAttributeValue(
        attributeValueId: attributeValueId,
        value: value,
        color: color,
        attributeId: attributeId,
        order: order);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    getAttributeValues();
  }

  trashAttributeValue(int attributeValueId) async {
    state = state.copyWith(loading: true);
    final data = await attributeValuesRepo.trashAttributeValue(
        attributeValueId: attributeValueId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    getAttributeValues();
  }

  restoreAttributeValue(int attributeValueId) async {
    state = state.copyWith(loading: true);
    final data = await attributeValuesRepo.restoreAttributeValue(
        attributeValueId: attributeValueId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    getAttributeValues();
  }

  deleteAttributeValue(int attributeValueId) async {
    state = state.copyWith(loading: true);
    final data = await attributeValuesRepo.deleteAttributeValue(
        attributeValueId: attributeValueId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    getAttributeValues();
  }
}
