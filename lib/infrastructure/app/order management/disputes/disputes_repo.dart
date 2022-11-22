import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/order%20management/dispute/dispute_details_model.dart';
import 'package:zcart_seller/domain/app/order%20management/dispute/dispute_pagination_model.dart';
import 'package:zcart_seller/domain/app/order%20management/dispute/i_dispute_repo.dart';

class DisputeRepo extends IDisputeRepo {
  final cleanApi = CleanApi.instance;

  @override
  Future<Either<CleanFailure, DisputePaginationModel>> getDisputes(
      {required int page}) {
    return cleanApi.get(
        failureHandler:
            <DisputeModel>(int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'dispute', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'dispute',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'dispute',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'dispute', error: responseBody.toString()));
          }
        },
        fromData: ((json) => DisputePaginationModel.fromMap(json)),
        endPoint: 'disputes?page=$page');
  }

  @override
  Future<Either<CleanFailure, Unit>> responseDisputes(
      {required disputeId,
      required int statusId,
      required String reply}) async {
    return await cleanApi.post(
        failureHandler:
            <Unit>(int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'dispute', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'dispute',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'dispute',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'dispute', error: responseBody.toString()));
          }
        },
        fromData: (josn) => unit,
        body: null,
        endPoint:
            'dispute/$disputeId/response?status_id=$statusId&reply=$reply');
  }

  @override
  Future<Either<CleanFailure, DisputeDetailsModel>> getDisputeDetails(
      {required int dispiteId}) {
    return cleanApi.get(
        failureHandler:
            <DisputeDetailsModel>(int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'dispute', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'dispute',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'dispute',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'dispute', error: responseBody.toString()));
          }
        },
        fromData: ((json) => DisputeDetailsModel.fromMap(json['data'])),
        endPoint: 'dispute/$dispiteId');
  }
}
