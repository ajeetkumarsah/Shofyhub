import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/order%20management/refunds/refund_state.dart';
import 'package:zcart_seller/domain/app/order%20management/refund/i_refund_repo.dart';
import 'package:zcart_seller/infrastructure/app/order%20management/refunds/refund_repo.dart';

final refundProvider =
    StateNotifierProvider<RefundNotifier, RefundState>((ref) {
  return RefundNotifier(RefundRepo());
});

class RefundNotifier extends StateNotifier<RefundState> {
  final IRefundRepo refundRepo;
  RefundNotifier(this.refundRepo) : super(RefundState.init());

  getOpenRefunds() async {
    state = state.copyWith(loading: true);
    final data = await refundRepo.getOpenRefunds();
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), openRefunds: r));
    Logger.i(state.openRefunds);
  }

  getClosedRefunds() async {
    state = state.copyWith(loading: true);
    final data = await refundRepo.getClosedRefunds();
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), closedRefunds: r));
    Logger.i(state.closedRefunds);
  }

  getRefundDetails({required int refundId}) async {
    state = state.copyWith(loading: true);
    final data = await refundRepo.getRefundDetails(refundId: refundId);
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), refundDetails: r));
    Logger.i(state.refundDetails);
  }

  approveRefund({required int refundId}) async {
    state = state.copyWith(loading: true);
    final data = await refundRepo.approveRefunds(refundId: refundId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getOpenRefunds();
    getClosedRefunds();
  }

  declineRefund({required int refundId}) async {
    state = state.copyWith(loading: true);
    final data = await refundRepo.declineRefunds(refundId: refundId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getOpenRefunds();
    getClosedRefunds();
  }

  initiateRefund(
      {required int shopId,
      required int orderId,
      required String amount,
      required String returnGoods,
      required String orderFulfilled,
      required String description,
      required int notifyCustomer,
      required int status}) async {
    state = state.copyWith(loading: true);
    final data = await refundRepo.initiateRefund(
        shopId: shopId,
        orderId: orderId,
        amount: amount,
        returnGoods: returnGoods,
        orderFulfilled: orderFulfilled,
        description: description,
        notifyCustomer: notifyCustomer,
        status: status);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getOpenRefunds();
    getClosedRefunds();
  }
}
