import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/form/key_value_form_state.dart';
import 'package:zcart_seller/domain/app/form/i_form_repo.dart';
import 'package:zcart_seller/infrastructure/app/form/form_repo.dart';

final attributeListProvider =
    StateNotifierProvider.autoDispose<AttributeListNotifier, KeyValueFormState>(
        (ref) {
  return AttributeListNotifier(repo: FormRepo());
});

class AttributeListNotifier extends StateNotifier<KeyValueFormState> {
  final IFormRepo repo;
  AttributeListNotifier({required this.repo}) : super(KeyValueFormState.init());

  loadData() async {
    state = state.copyWith(loading: true);
    final data = await repo.getAttributesList();
    state = data.fold(
      (l) => state.copyWith(loading: false, failure: l),
      (r) => state.copyWith(loading: false, dataList: r),
    );
  }
}
