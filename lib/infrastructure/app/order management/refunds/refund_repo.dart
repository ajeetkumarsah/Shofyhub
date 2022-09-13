import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/order%20management/refund/i_refund_repo.dart';
import 'package:zcart_seller/domain/app/order%20management/refund/refund_model.dart';

class RefundRepo extends IRefundRepo {
  final cleanApi = CleanApi.instance;
  @override
  Future<Either<CleanFailure, List<RefundModel>>> getOpenRefunds() async {
    return cleanApi.get(
        failureHandler:
            <RefundModel>(int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'refund', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'refund',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'refund',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'refund', error: responseBody.toString()));
          }
        },
        fromData: ((json) => List<RefundModel>.from(
            json['data'].map((e) => RefundModel.fromMap(e)))),
        endPoint: 'refunds/open');
  }

  @override
  Future<Either<CleanFailure, List<RefundModel>>> getClosedRefunds() async {
    return cleanApi.get(
        failureHandler:
            <RefundModel>(int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'refund', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'refund',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'refund',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'refund', error: responseBody.toString()));
          }
        },
        fromData: ((json) => List<RefundModel>.from(
            json['data'].map((e) => RefundModel.fromMap(e)))),
        endPoint: 'refunds/closed');
  }

  @override
  Future<Either<CleanFailure, RefundModel>> getRefundDetails(
      {required int refundId}) async {
    return cleanApi.get(
        failureHandler:
            <RefundModel>(int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'refund', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'refund',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'refund',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'refund', error: responseBody.toString()));
          }
        },
        fromData: ((json) => RefundModel.fromMap(json["date"])),
        endPoint: 'refund/$refundId');
  }

  @override
  Future<Either<CleanFailure, Unit>> approveRefunds(
      {required int refundId}) async {
    return cleanApi.post(
        failureHandler:
            <Unit>(int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'refund', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'refund',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'refund',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'refund', error: responseBody.toString()));
          }
        },
        fromData: (json) => unit,
        body: null,
        endPoint: 'refund/$refundId/approve');
  }

  @override
  Future<Either<CleanFailure, Unit>> declineRefunds(
      {required int refundId}) async {
    return cleanApi.get(
        failureHandler:
            <Unit>(int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'refund', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'refund',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'refund',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'refund', error: responseBody.toString()));
          }
        },
        fromData: (json) => unit,
        endPoint: 'refund/$refundId/decline');
  }

  @override
  Future<Either<CleanFailure, Unit>> initiateRefund(
      {required int shopId,
      required int orderId,
      required String amount,
      required String returnGoods,
      required String orderFulfilled,
      required String description,
      required int notifyCustomer,
      required int status}) async {
    return cleanApi.post(
      failureHandler:
          <Unit>(int statusCode, Map<String, dynamic> responseBody) {
        if (responseBody['errors'] != null) {
          final errors =
              Map<String, dynamic>.from(responseBody['errors']).values.toList();
          final error = List.from(errors.first);
          return left(CleanFailure(tag: 'refund', error: error.first));
        } else if (responseBody['message'] != null) {
          return left(CleanFailure(
              tag: 'refund',
              error: responseBody['message'],
              statusCode: statusCode));
        } else if (responseBody['error'] != null) {
          return left(CleanFailure(
              tag: 'refund',
              error: responseBody['error'],
              statusCode: statusCode));
        } else {
          return left(
              CleanFailure(tag: 'refund', error: responseBody.toString()));
        }
      },
      fromData: (json) => unit,
      body: null,
      endPoint:
          'refund/initiate?status=$status&amount=$amount&return_goods=$returnGoods&order_fulfilled=$orderFulfilled&description=$description&notify_customer=$notifyCustomer&shop_id=$shopId&order_id=$orderId',
    );
  }
}
