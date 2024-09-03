import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/application/app/delivary_boys/delivary_state.dart';
import 'package:alpesportif_seller/domain/app/delivary%20boy/i_delivary_boy_repo.dart';
import 'package:alpesportif_seller/infrastructure/app/delivary%20boys/delivary_boys_repo.dart';

final delivaryProvider =
    StateNotifierProvider<DelivaryNotifier, DelivaryState>((ref) {
  return DelivaryNotifier(DelivaryRepo());
});

class DelivaryNotifier extends StateNotifier<DelivaryState> {
  final IDelivaryRepo delivaryBoyRepo;
  DelivaryNotifier(this.delivaryBoyRepo) : super(DelivaryState.init());

  getDelivaryBoys() async {
    state = state.copyWith(loading: true);
    final data = await delivaryBoyRepo.getDelivaryBoys();
    state = data.fold(
      (l) => state.copyWith(loading: false, failure: l),
      (r) => state.copyWith(
          loading: false, failure: CleanFailure.none(), delivaryBoys: r),
    );
    Logger.i(state.delivaryBoys);
  }
}
