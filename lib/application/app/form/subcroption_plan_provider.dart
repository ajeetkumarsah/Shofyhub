import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/domain/app/form/i_form_repo.dart';
import 'package:alpesportif_seller/infrastructure/app/form/form_repo.dart';

import 'key_value_form_state.dart';

final subscriptionplanProvider =
    StateNotifierProvider<SubcriptionPlanNotifier, KeyValueFormState>((ref) {
  return SubcriptionPlanNotifier(repo: FormRepo());
});

class SubcriptionPlanNotifier extends StateNotifier<KeyValueFormState> {
  final IFormRepo repo;
  SubcriptionPlanNotifier({required this.repo})
      : super(KeyValueFormState.init());

  getPlans() async {
    state = state.copyWith(loading: true);
    final data = await repo.getPlans();
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, dataList: r));
  }
}
