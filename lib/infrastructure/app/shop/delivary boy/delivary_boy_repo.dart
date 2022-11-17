import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/shop/delivery%20boy/delivary_boy_model.dart';
import 'package:zcart_seller/domain/app/shop/delivery%20boy/create_delivary_boy_model.dart';

import 'package:zcart_seller/domain/app/shop/delivery%20boy/i_delivary_boy_repo.dart';

class DelivaryBoyRepo extends IDelivaryBoyRepo {
  final cleanApi = CleanApi.instance;

  @override
  Future<Either<CleanFailure, List<DelivaryBoyModel>>>
      getAllDelivaryBoy({required String filter}) async {
    return cleanApi.get(
        fromData: ((json) => List<DelivaryBoyModel>.from(
            json['data'].map((e) => DelivaryBoyModel.fromMap(e)))),
        endPoint: 'delivery-boys?filter=$filter');
  }

  @override
  Future<Either<CleanFailure, Unit>> createDelivaryBoy(
      {required CreateDelivaryBoyModel delivaryBoy}) async {
    return cleanApi.post(
      fromData: (json) => unit,
      body: null,
      endPoint:
          'delivery-boy/create?shop_id=${delivaryBoy.shopId}&first_name=${delivaryBoy.firstName}&last_name=${delivaryBoy.lastName}&nice_name=${delivaryBoy.niceName}&email=${delivaryBoy.email}&phone_number=${delivaryBoy.phoneNumber}&password=${delivaryBoy.password}&password_confirmation=${delivaryBoy.confirmPassword}&status=${delivaryBoy.status}&dob=${delivaryBoy.dob}&sex=${delivaryBoy.sex}',
    );
  }

  @override
  Future<Either<CleanFailure, Unit>> deleteDelivaryBoy(
      {required int delivaryBoyId}) async {
    return cleanApi.delete(
        fromData: (json) => unit,
        endPoint: 'delivery-boy/$delivaryBoyId/delete');
  }

  @override
  Future<Either<CleanFailure, DelivaryBoyModel>> getDelivaryBoyDetails(
      {required int delivaryBoyId}) async {
    return cleanApi.get(
        fromData: (json) => DelivaryBoyModel.fromMap(json),
        endPoint: 'delivery-boy/$delivaryBoyId');
  }

  @override
  Future<Either<CleanFailure, Unit>> restoreDelivaryBoy(
      {required int delivaryBoyId}) async {
    return cleanApi.put(
        fromData: (json) => unit,
        body: null,
        endPoint: 'delivery-boy/$delivaryBoyId/restore');
  }

  @override
  Future<Either<CleanFailure, Unit>> trashDelivaryBoy(
      {required int delivaryBoyId}) async {
    return cleanApi.delete(
        fromData: (json) => unit,
        endPoint: 'delivery-boy/$delivaryBoyId/trash');
  }

  @override
  Future<Either<CleanFailure, Unit>> updateDelivaryBoy(
      {required CreateDelivaryBoyModel delivaryBoy, required int id}) async {
    return cleanApi.put(
      fromData: (json) => unit,
      body: null,
      endPoint:
          'delivery-boy/$id/update?shop_id=${delivaryBoy.shopId}&first_name=${delivaryBoy.firstName}&last_name=${delivaryBoy.lastName}&nice_name=${delivaryBoy.niceName}&email=${delivaryBoy.email}&phone_number=${delivaryBoy.phoneNumber}&password=${delivaryBoy.password}&status=${delivaryBoy.status}&dob=${delivaryBoy.dob}&sex=${delivaryBoy.sex}',
    );
  }
}
