import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/application/app/catalog/attribute%20values/attribute_value_details_state.dart';
import 'package:alpesportif_seller/domain/app/catalog/attribute%20values/i_attribute_values_repo.dart';
import 'package:alpesportif_seller/infrastructure/app/catalog/attribute%20values/attribute_values_repo.dart';

final attributeValueDetailsProvider = StateNotifierProvider.family
    .autoDispose<AttributeValuesNotifier, AttributeValueDetalsState, int>(
        (ref, id) {
  return AttributeValuesNotifier(id, AttributeValuesRepo());
});

class AttributeValuesNotifier extends StateNotifier<AttributeValueDetalsState> {
  final int id;
  final IAttributeValuesRepo attributeValuesRepo;
  AttributeValuesNotifier(this.id, this.attributeValuesRepo)
      : super(AttributeValueDetalsState.init());

  getAttributeValuesData() async {
    state = state.copyWith(loading: true);
    final data = await attributeValuesRepo.getAttributeValueDetails(
        attributeValueId: id);
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false,
            failure: CleanFailure.none(),
            attributeValueDetails: r));
    Logger.i(data);
  }
}
