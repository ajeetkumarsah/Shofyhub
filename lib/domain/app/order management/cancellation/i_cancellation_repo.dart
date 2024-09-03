import 'package:clean_api/clean_api.dart';
import 'package:alpesportif_seller/domain/app/order%20management/cancellation/cancellation_pagination_model.dart';

abstract class ICancellationRepo {
  Future<Either<CleanFailure, CancellationPaginationModel>> getCancellations(
      {required int page});
  Future<Either<CleanFailure, Unit>> approveCancellation({required int id});
  Future<Either<CleanFailure, Unit>> declineCancellation({required int id});
}
