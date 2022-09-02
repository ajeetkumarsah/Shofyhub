import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/form/key_value_form_state.dart';
import 'package:zcart_seller/domain/app/form/i_form_repo.dart';
import 'package:zcart_seller/infrastructure/app/form/form_repo.dart';

final countryProvider =
    StateNotifierProvider.autoDispose<CountryNotifier, KeyValueFormState>(
        (ref) {
  return CountryNotifier(repo: FormRepo());
});

class CountryNotifier extends StateNotifier<KeyValueFormState> {
  final IFormRepo repo;
  CountryNotifier({required this.repo}) : super(KeyValueFormState.init());

  loadData() async {
    state = state.copyWith(loading: true);
    final data = await repo.getCountryList();
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, dataList: r));
  }

  loadState({required int id}) async {
    state = state.copyWith(loading: true);
    final data = await repo.getStateList(id: id);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, stateList: r));
  }
}
