import 'package:clean_api/clean_api.dart';
import 'package:alpesportif_seller/domain/app/order%20management/dispute/dispute_details_model.dart';
import 'package:alpesportif_seller/domain/app/order%20management/dispute/dispute_pagination_model.dart';

abstract class IDisputeRepo {
  Future<Either<CleanFailure, DisputePaginationModel>> getDisputes(
      {required int page});
  Future<Either<CleanFailure, DisputeDetailsModel>> getDisputeDetails(
      {required int dispiteId});
  Future<Either<CleanFailure, Unit>> responseDisputes(
      {required disputeId, required int statusId, required String reply});
}
