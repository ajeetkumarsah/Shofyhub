import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/domain/app/form/i_form_repo.dart';

import 'key_value_form_state.dart';

class ItemConditionNotifier extends StateNotifier<KeyValueFormState> {
  final IFormRepo repo;
  ItemConditionNotifier({required this.repo}): super(KeyValueFormState.init());

  getItemCondition() async {
    state = state.copyWith(loading: true);
    final data = await repo.getItemCondition();
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, dataList: r));
  }
  
}