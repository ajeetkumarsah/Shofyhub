import 'dart:io';

import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/order/order_details/order_details_model.dart';
import 'package:zcart_seller/domain/app/order/order_model.dart';
import 'package:zcart_seller/domain/app/order/order_status_model.dart';

abstract class IOrderRepo {
  Future<Either<CleanFailure, List<OrderModel>>> getOrders(
      {required String? filter});
  Future<Either<CleanFailure, List<OrderModel>>> getArchivedOrder();
  Future<Either<CleanFailure, Unit>> assignDelivaryBoy(
      {required int orderId, required int delivaryBoyId});
  Future<Either<CleanFailure, OrderDetailsModel>> getOrderDetails(
      {required int orderId});
  Future<Either<CleanFailure, Unit>> fulfillOrder(
      {required int orderId,
      required int carrierId,
      required String trackingId,
      required bool notifyCustomer});
  Future<Either<CleanFailure, Unit>> updateOrderStatus(
      {required int orderId,
      required int orderStatusId,
      required bool notifyCustomer});
  Future<Either<CleanFailure, Unit>> markAsPaid({required int orderId});
  Future<Either<CleanFailure, Unit>> markAsUnpaid({required int orderId});
  Future<Either<CleanFailure, Unit>> markAsDelivered(
      {required int orderId, required bool notifyCustomer});
  Future<Either<CleanFailure, Unit>> cancleOrder(
      {required int orderId, required bool notifyCustomer});
  Future<Either<CleanFailure, Unit>> unarchiveOrder({required int orderId});
  Future<Either<CleanFailure, Unit>> archiveOrder({required int orderId});
  Future<Either<CleanFailure, Unit>> deleteOrder({required int orderId});

  Future<Either<CleanFailure, Unit>> adminNote(
      {required int orderId, required String adminNote});

  Future<Either<CleanFailure, List<OrderStatusModel>>> getOrderStatus();

  Future<Either<CleanFailure, File>> getInvoice({required int orderId});
}
