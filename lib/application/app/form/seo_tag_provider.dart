import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/domain/app/form/i_form_repo.dart';
import 'package:zcart_seller/infrastructure/app/form/form_repo.dart';

import 'key_value_form_state.dart';

final seotagProvider =
    StateNotifierProvider.autoDispose<SeoTagNotifier, KeyValueFormState>(
        (ref) {
  return SeoTagNotifier(repo: FormRepo());
});

class SeoTagNotifier extends StateNotifier<KeyValueFormState> {
  final IFormRepo repo;
  SeoTagNotifier({required this.repo}) : super(KeyValueFormState.init());

  getseotag() async {
    state = state.copyWith(loading: true);
    final data = await repo.getseotag();
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, dataList: r));
  }
}
