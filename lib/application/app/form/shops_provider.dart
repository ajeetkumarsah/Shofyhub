import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/application/app/form/key_value_form_state.dart';
import 'package:alpesportif_seller/domain/app/form/i_form_repo.dart';
import 'package:alpesportif_seller/infrastructure/app/form/form_repo.dart';

final shopsProvider =
    StateNotifierProvider.autoDispose<ShopsNotifier, KeyValueFormState>((ref) {
  return ShopsNotifier(repo: FormRepo());
});

class ShopsNotifier extends StateNotifier<KeyValueFormState> {
  final IFormRepo repo;
  ShopsNotifier({required this.repo}) : super(KeyValueFormState.init());

  getShop() async {
    state = state.copyWith(loading: true);
    final data = await repo.getShop();
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, dataList: r));
  }
}
