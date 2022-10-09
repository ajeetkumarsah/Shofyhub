import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/order%20management/dispute/dispute_state.dart';
import 'package:zcart_seller/domain/app/order%20management/dispute/dispute_mode.dart';
import 'package:zcart_seller/domain/app/order%20management/dispute/dispute_pagination_model.dart';
import 'package:zcart_seller/domain/app/order%20management/dispute/i_dispute_repo.dart';
import 'package:zcart_seller/infrastructure/app/order%20management/disputes/disputes_repo.dart';

final disputeProvider =
    StateNotifierProvider<DisputeNotifier, DisputeState>((ref) {
  return DisputeNotifier(DisputeRepo());
});

class DisputeNotifier extends StateNotifier<DisputeState> {
  final IDisputeRepo disputeRepo;
  DisputeNotifier(this.disputeRepo) : super(DisputeState.init());

  DisputePaginationModel disputePaginationModel = DisputePaginationModel.init();
  List<DisputeModel> disputes = [];
  int pageNumber = 1;

  getDisputes() async {
    pageNumber = 1;
    disputes = [];

    state = state.copyWith(loading: true);
    final data = await disputeRepo.getDisputes(page: pageNumber);

    //increase the page no
    pageNumber++;

    state = data.fold((l) => state.copyWith(loading: false, failure: l), (r) {
      disputePaginationModel = r;
      disputes.addAll(disputePaginationModel.data);

      return state.copyWith(
        loading: false,
        allDisputes: disputes,
        failure: CleanFailure.none(),
      );
    });
    Logger.i(state.allDisputes);
  }

  getMoreDisputes() async {
    if (pageNumber == 1 ||
        pageNumber <= disputePaginationModel.meta.lastPage!) {
      final data = await disputeRepo.getDisputes(page: pageNumber);

      //increase the page no
      pageNumber++;

      state = data.fold((l) => state.copyWith(loading: false, failure: l), (r) {
        disputePaginationModel = r;
        disputes.addAll(disputePaginationModel.data);

        return state.copyWith(
          loading: false,
          allDisputes: disputes,
          failure: CleanFailure.none(),
        );
      });
      Logger.i(state.allDisputes);
    }
  }

  responseDispute(int disputeId, int statusId, String reply) async {
    state = state.copyWith(loading: true);
    await disputeRepo.responseDisputes(
        disputeId: disputeId, statusId: statusId, reply: reply);
    state = state.copyWith(loading: false);
    getDisputes();
  }
}
