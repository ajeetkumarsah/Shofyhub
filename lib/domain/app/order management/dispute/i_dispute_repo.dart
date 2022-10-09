import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/order%20management/dispute/dispute_pagination_model.dart';

abstract class IDisputeRepo {
  Future<Either<CleanFailure, DisputePaginationModel>> getDisputes(
      {required int page});
  Future<Either<CleanFailure, Unit>> responseDisputes(
      {required disputeId, required int statusId, required String reply});
}
