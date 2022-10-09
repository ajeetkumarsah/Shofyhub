import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/dashboard/dashboard_state.dart';
import 'package:zcart_seller/domain/app/dashboard/i_dashboard_repo.dart';
import 'package:zcart_seller/infrastructure/app/dashboard/dashboard_repo.dart';

final dashboardProvider =
    StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
  return DashboardNotifier(DashboardRepo());
});

class DashboardNotifier extends StateNotifier<DashboardState> {
  final IDashBoardRepo dashboardRepo;
  DashboardNotifier(this.dashboardRepo) : super(DashboardState.init());

  getStatistics() async {
    state = state.copyWith(loading: true);
    final data = await dashboardRepo.getStatistics();
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), statistics: r));
    Logger.i(state.statistics);
  }

  getLatestOrders() async {
    state = state.copyWith(loading: true);
    final data = await dashboardRepo.getlatestOrders();
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), latestOrders: r));
    Logger.i(state.latestOrders);
  }

  getTopSellingItems() async {
    state = state.copyWith(loading: true);
    final data = await dashboardRepo.getTopSellingItems();
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), topSellingItems: r));
    Logger.i(state.topSellingItems);
  }

  getOutOfStocktems() async {
    state = state.copyWith(loading: true);
    final data = await dashboardRepo.getOutOfStockItems();
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), outOfStockItems: r));
    Logger.i(state.outOfStockItems);
  }
}
