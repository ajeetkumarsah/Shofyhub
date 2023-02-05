import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/order%20management/cancellation/cancellation_pagination_model.dart';
import 'package:zcart_seller/domain/app/order%20management/cancellation/i_cancellation_repo.dart';

class CancellationRepo extends ICancellationRepo {
  final cleanApi = CleanApi.instance;

  @override
  Future<Either<CleanFailure, CancellationPaginationModel>> getCancellations(
      {required int page}) {
    return cleanApi.get(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'cancellation', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'cancellation',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'cancellation',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(CleanFailure(
                tag: 'cancellation', error: responseBody.toString()));
          }
        },
        fromData: ((json) => CancellationPaginationModel.fromMap(json)),
        endPoint: 'cancellation/requests?page=$page');
  }

  @override
  Future<Either<CleanFailure, Unit>> approveCancellation(
      {required int id}) async {
    return await cleanApi.put(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'cancellation', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'cancellation',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'cancellation',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(CleanFailure(
                tag: 'cancellation', error: responseBody.toString()));
          }
        },
        fromData: (josn) => unit,
        body: null,
        endPoint: 'order/$id/approve_cancellation');
  }

  @override
  Future<Either<CleanFailure, Unit>> declineCancellation(
      {required int id}) async {
    return await cleanApi.put(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'cancellation', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'cancellation',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'cancellation',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(CleanFailure(
                tag: 'cancellation', error: responseBody.toString()));
          }
        },
        fromData: (josn) => unit,
        body: null,
        endPoint: 'order/$id/decline_cancellation');
  }
}
