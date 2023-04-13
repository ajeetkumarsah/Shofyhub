import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/carriers/carriers_state.dart';
import 'package:zcart_seller/domain/app/carriers/i_carrier_repo.dart';
import 'package:zcart_seller/infrastructure/app/carriers/carriers_repo.dart';

final carriersProvider =
    StateNotifierProvider<CarriersNotifier, CarriersState>((ref) {
  return CarriersNotifier(CarriersRepo());
});

class CarriersNotifier extends StateNotifier<CarriersState> {
  final ICarrierRepo carrierRepo;
  CarriersNotifier(this.carrierRepo) : super(CarriersState.init());

  getCarrier() async {
    state = state.copyWith(loading: true);
    final data = await carrierRepo.getCarriers();
    state = data.fold((l) {
      return state.copyWith(
        loading: false,
        failure: l,
      );
    }, (r) {
      return state.copyWith(
          loading: false, failure: CleanFailure.none(), carriers: r);
    });

    Logger.i("Carriers: ${state.carriers}");
  }
}
