import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/order%20management/refund/refund_model.dart';

abstract class IRefundRepo {
  Future<Either<CleanFailure, List<RefundModel>>> getOpenRefunds();
  Future<Either<CleanFailure, List<RefundModel>>> getClosedRefunds();
  Future<Either<CleanFailure, RefundModel>> getRefundDetails(
      {required int refundId});
  Future<Either<CleanFailure, Unit>> approveRefunds({required int refundId});
  Future<Either<CleanFailure, Unit>> declineRefunds({required int refundId});
  Future<Either<CleanFailure, Unit>> initiateRefund(
      {required int shopId,
      required int orderId,
      required String amount,
      required String returnGoods,
      required String orderFulfilled,
      required String description,
      required int notifyCustomer,
      required int status});
}
