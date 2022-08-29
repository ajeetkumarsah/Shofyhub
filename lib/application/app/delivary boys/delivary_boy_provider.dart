import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_vendor/application/app/delivary%20boys/delivary_boy_state.dart';
import 'package:zcart_vendor/domain/app/delivary%20boy/i_delivary_boy_repo.dart';
import 'package:zcart_vendor/infrastructure/app/delivary%20boys/delivary_boys_repo.dart';

final delivaryBoyProvider =
    StateNotifierProvider<DelivaryBoyNotifier, DelivaryBoyState>((ref) {
  return DelivaryBoyNotifier(DelivaryBoyRepo());
});

class DelivaryBoyNotifier extends StateNotifier<DelivaryBoyState> {
  final IDelivaryBoyRepo delivaryBoyRepo;
  DelivaryBoyNotifier(this.delivaryBoyRepo) : super(DelivaryBoyState.init());

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
