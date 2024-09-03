import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/application/app/order%20management/cancellation/cancellation_state.dart';
import 'package:alpesportif_seller/domain/app/order%20management/cancellation/cancellation_model.dart';
import 'package:alpesportif_seller/domain/app/order%20management/cancellation/cancellation_pagination_model.dart';
import 'package:alpesportif_seller/domain/app/order%20management/cancellation/i_cancellation_repo.dart';
import 'package:alpesportif_seller/infrastructure/app/order%20management/cancellations/cancellation_repo.dart';

final cancellationProvider =
    StateNotifierProvider<CancellationNotifier, CancellationState>((ref) {
  return CancellationNotifier(CancellationRepo());
});

class CancellationNotifier extends StateNotifier<CancellationState> {
  final ICancellationRepo cancellationRepo;
  CancellationNotifier(this.cancellationRepo) : super(CancellationState.init());

  CancellationPaginationModel cancellationPaginationModel =
      CancellationPaginationModel.init();
  List<CancellationModel> cancellations = [];
  int pageNumber = 1;

  getCancellations() async {
    pageNumber = 1;
    cancellations = [];

    state = state.copyWith(loading: true);
    final data = await cancellationRepo.getCancellations(page: pageNumber);

    //increase the page no
    pageNumber++;

    state = data.fold((l) => state.copyWith(loading: false, failure: l), (r) {
      cancellationPaginationModel = r;
      cancellations.addAll(cancellationPaginationModel.data);

      return state.copyWith(
        loading: false,
        allCancellations: cancellations,
        failure: CleanFailure.none(),
      );
    });
    Logger.i(state.allCancellations);
  }

  getMorecancellation() async {
    if (pageNumber == 1 ||
        pageNumber <= cancellationPaginationModel.meta.lastPage!) {
      final data = await cancellationRepo.getCancellations(page: pageNumber);

      //increase the page no
      pageNumber++;

      state = data.fold((l) => state.copyWith(loading: false, failure: l), (r) {
        cancellationPaginationModel = r;
        cancellations.addAll(cancellationPaginationModel.data);

        return state.copyWith(
          loading: false,
          allCancellations: cancellations,
          failure: CleanFailure.none(),
        );
      });
      Logger.i(state.allCancellations);
    }
  }

  approveCancellation(int id) async {
    state = state.copyWith(loading: true);
    await cancellationRepo.approveCancellation(id: id);
    state = state.copyWith(loading: false);
    getCancellations();
  }

  declineCancellation(int id) async {
    state = state.copyWith(loading: true);
    await cancellationRepo.declineCancellation(id: id);
    state = state.copyWith(loading: false);
    getCancellations();
  }
}
