import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/shop/delivary%20boy/delivary_boy_state.dart';
import 'package:zcart_seller/domain/app/shop/delivery%20boy/create_delivary_boy_model.dart';
import 'package:zcart_seller/domain/app/shop/delivery%20boy/i_delivary_boy_repo.dart';
import 'package:zcart_seller/infrastructure/app/shop/delivary%20boy/delivary_boy_repo.dart';

final delivaryBoyProvider =
    StateNotifierProvider<DelivaryBoyNotifier, DelivaryBoyState>((ref) {
  return DelivaryBoyNotifier(DelivaryBoyRepo());
});

class DelivaryBoyNotifier extends StateNotifier<DelivaryBoyState> {
  final IDelivaryBoyRepo delivaryBoyRepo;
  DelivaryBoyNotifier(this.delivaryBoyRepo) : super(DelivaryBoyState.init());

  getAllDelivaryBoy() async {
    state = state.copyWith(loading: true);
    final data = await delivaryBoyRepo.getAllDelivaryBoy(filter: 'null');
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), delivaryBoyList: r));
  }

  getTrashDelivaryBoy() async {
    state = state.copyWith(loading: true);
    final data = await delivaryBoyRepo.getAllDelivaryBoy(filter: 'trash');
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false,
            failure: CleanFailure.none(),
            trashDelivaryBoyList: r));
  }

  createDelivaryBoy({required CreateDelivaryBoyModel delivaryBoy}) async {
    state = state.copyWith(loading: true);
    final data =
        await delivaryBoyRepo.createDelivaryBoy(delivaryBoy: delivaryBoy);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getAllDelivaryBoy();
  }

  trashDelivaryBoy({required int delivaryBoyID}) async {
    state = state.copyWith(loading: true);
    final data =
        await delivaryBoyRepo.trashDelivaryBoy(delivaryBoyId: delivaryBoyID);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getAllDelivaryBoy();
    getTrashDelivaryBoy();
  }

  restoreDelivaryBoy({required int delivaryBoyID}) async {
    state = state.copyWith(loading: true);
    final data =
        await delivaryBoyRepo.restoreDelivaryBoy(delivaryBoyId: delivaryBoyID);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getAllDelivaryBoy();
    getTrashDelivaryBoy();
  }

  deleteDelivaryBoy({required int delivaryBoyID}) async {
    state = state.copyWith(loading: true);
    final data =
        await delivaryBoyRepo.deleteDelivaryBoy(delivaryBoyId: delivaryBoyID);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getAllDelivaryBoy();
    getTrashDelivaryBoy();
  }

  updateDelivaryBoy(
      {required CreateDelivaryBoyModel delivaryBoy,
      required int delivaryBoyId}) async {
    state = state.copyWith(loading: true);
    final data = await delivaryBoyRepo.updateDelivaryBoy(
        delivaryBoy: delivaryBoy, id: delivaryBoyId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getAllDelivaryBoy();
  }
}
