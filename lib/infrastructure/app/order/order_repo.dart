// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:clean_api/clean_api.dart';
import 'package:alpesportif_seller/domain/app/order/i_order_repo.dart';
import 'package:alpesportif_seller/domain/app/order/order_details/order_details_model.dart';
import 'package:alpesportif_seller/domain/app/order/order_model.dart';
import 'package:alpesportif_seller/domain/app/order/order_pagination_model.dart';
import 'package:alpesportif_seller/domain/app/order/order_status_model.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';

class OrderRepo extends IOrderRepo {
  final cleanApi = CleanApi.instance;

  @override
  Future<Either<CleanFailure, OrderPaginationModel>> getOrders(
      {required String? filter, required int page}) async {
    return cleanApi.get(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'order', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'order',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'order',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'order', error: responseBody.toString()));
          }
        },
        fromData: ((json) => OrderPaginationModel.fromMap(json)),
        endPoint: "orders?filter=$filter&page=$page");
  }

  @override
  Future<Either<CleanFailure, List<OrderModel>>> getArchivedOrder() async {
    return cleanApi.get(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'order', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'order',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'order',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'order', error: responseBody.toString()));
          }
        },
        fromData: ((json) => List<OrderModel>.from(
            json['data'].map((e) => OrderModel.fromMap(e)))),
        endPoint: 'orders?filter=archived');
  }

  @override
  Future<Either<CleanFailure, Unit>> assignDelivaryBoy(
      {required int orderId, required int delivaryBoyId}) async {
    return cleanApi.post(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'order', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'order',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'order',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'order', error: responseBody.toString()));
          }
        },
        fromData: (json) => unit,
        body: null,
        endPoint:
            "order/$orderId/assign_delivery_boy?delivery_boy_id=$delivaryBoyId");
  }

  @override
  Future<Either<CleanFailure, Unit>> fulfillOrder(
      {required int orderId,
      required int carrierId,
      required String trackingId,
      required bool notifyCustomer}) async {
    return cleanApi.post(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'order', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'order',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'order',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'order', error: responseBody.toString()));
          }
        },
        fromData: (json) => unit,
        body: null,
        endPoint:
            "order/$orderId/fulfill?carrier_id=$carrierId&tracking_id=$trackingId&notify_customer=$notifyCustomer");
  }

  @override
  Future<Either<CleanFailure, Unit>> updateOrderStatus(
      {required int orderId,
      required int orderStatusId,
      required bool notifyCustomer}) async {
    return cleanApi.put(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'order', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'order',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'order',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'order', error: responseBody.toString()));
          }
        },
        fromData: (json) => unit,
        body: null,
        endPoint:
            "order/$orderId/update_status?status_id=$orderStatusId&notify_customer=$notifyCustomer");
  }

  @override
  Future<Either<CleanFailure, Unit>> markAsPaid({required int orderId}) async {
    return cleanApi.put(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'order', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'order',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'order',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'order', error: responseBody.toString()));
          }
        },
        fromData: (json) => unit,
        body: null,
        endPoint: 'order/$orderId/mark_as_paid');
  }

  @override
  Future<Either<CleanFailure, Unit>> markAsUnpaid(
      {required int orderId}) async {
    return cleanApi.put(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'order', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'order',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'order',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'order', error: responseBody.toString()));
          }
        },
        fromData: (json) => unit,
        body: null,
        endPoint: 'order/$orderId/mark_as_unpaid');
  }

  @override
  Future<Either<CleanFailure, Unit>> markAsDelivered(
      {required int orderId, required bool notifyCustomer}) async {
    return cleanApi.put(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'order', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'order',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'order',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'order', error: responseBody.toString()));
          }
        },
        fromData: (json) => unit,
        body: null,
        endPoint: 'order/$orderId/delivered?notify_customer=$notifyCustomer');
  }

  @override
  Future<Either<CleanFailure, Unit>> cancleOrder(
      {required int orderId, required bool notifyCustomer}) async {
    return cleanApi.put(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'order', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'order',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'order',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'order', error: responseBody.toString()));
          }
        },
        fromData: (json) => unit,
        body: null,
        endPoint: 'order/$orderId/cancel?notify_customer=$notifyCustomer');
  }

  @override
  Future<Either<CleanFailure, Unit>> unarchiveOrder(
      {required int orderId}) async {
    return cleanApi.put(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'order', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'order',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'order',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'order', error: responseBody.toString()));
          }
        },
        fromData: (json) => unit,
        body: null,
        endPoint: 'order/$orderId/unarchive');
  }

  @override
  Future<Either<CleanFailure, Unit>> archiveOrder(
      {required int orderId}) async {
    return cleanApi.delete(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'order', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'order',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'order',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'order', error: responseBody.toString()));
          }
        },
        fromData: (json) => unit,
        body: null,
        endPoint: 'order/$orderId/archive');
  }

  @override
  Future<Either<CleanFailure, Unit>> deleteOrder({required int orderId}) async {
    return cleanApi.delete(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'order', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'order',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'order',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'order', error: responseBody.toString()));
          }
        },
        fromData: (json) => unit,
        body: null,
        endPoint: 'order/$orderId');
  }

  @override
  Future<Either<CleanFailure, OrderDetailsModel>> getOrderDetails(
      {required int orderId}) async {
    return cleanApi.get(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'order', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'order',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'order',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'order', error: responseBody.toString()));
          }
        },
        fromData: (json) => OrderDetailsModel.fromMap(json["data"]),
        endPoint: "order/$orderId");
  }

  @override
  Future<Either<CleanFailure, List<OrderStatusModel>>> getOrderStatus() async {
    return cleanApi.get(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'order', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'order',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'order',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'order', error: responseBody.toString()));
          }
        },
        fromData: (json) => List<OrderStatusModel>.from(json
            .map((key, value) =>
                MapEntry(key, OrderStatusModel(id: key, name: value)))
            .values),
        endPoint: 'data/order_statuses');
  }

  @override
  Future<Either<CleanFailure, Unit>> adminNote(
      {required int orderId, required String adminNote}) async {
    return await cleanApi.post(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'order', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'order',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'order',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'order', error: responseBody.toString()));
          }
        },
        fromData: (json) => unit,
        body: null,
        endPoint: 'order/$orderId/add_note?note=$adminNote');
  }

  @override
  Future<Either<CleanFailure, File>> getInvoice({required int orderId}) async {
    final response =
        await cleanApi.getResponse(endPoint: 'order/$orderId/invoice');
    return await response.fold((l) => left(l), (r) async {
      try {
        final File _file = File(await getTemporaryDirectory()
            .then((value) => "${value.path}/invoice.pdf"));
        final _res = await _file.writeAsBytes(r.bodyBytes);
        return right(_res);
      } catch (e) {
        return left(CleanFailure(tag: 'Pdf', error: e.toString()));
      }
    });
  }
}
