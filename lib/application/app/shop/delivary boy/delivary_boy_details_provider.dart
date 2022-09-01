import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/shop/delivary%20boy/delivary_boy_details_state.dart';
import 'package:zcart_seller/domain/app/shop/delivery%20boy/i_delivary_boy_repo.dart';
import 'package:zcart_seller/infrastructure/app/shop/delivary%20boy/delivary_boy_repo.dart';

final delivaryBoyDetailsProvider = StateNotifierProvider.family<
    DelivaryBoyDetailsNotifier,
    DelivaryBoyDetailsState,
    int>((ref, delivaryBoyId) {
  return DelivaryBoyDetailsNotifier(DelivaryBoyRepo(), delivaryBoyId);
});

class DelivaryBoyDetailsNotifier
    extends StateNotifier<DelivaryBoyDetailsState> {
  final IDelivaryBoyRepo delivaryBoyRepo;
  final int delivaryBoyId;
  DelivaryBoyDetailsNotifier(this.delivaryBoyRepo, this.delivaryBoyId)
      : super(DelivaryBoyDetailsState.init());

  getDelivaryBoyDetails() async {
    state = state.copyWith(loading: true);
    final data = await delivaryBoyRepo.getDelivaryBoyDetails(
        delivaryBoyId: delivaryBoyId);
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false,
            failure: CleanFailure.none(),
            delivaryBoyDetails: r));
  }
}
