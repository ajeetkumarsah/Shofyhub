import 'package:clean_api/clean_api.dart';
import 'package:alpesportif_seller/domain/app/shop/delivery%20boy/create_delivary_boy_model.dart';
import 'package:alpesportif_seller/domain/app/shop/delivery%20boy/delivary_boy_model.dart';

abstract class IDelivaryBoyRepo {
  Future<Either<CleanFailure, List<DelivaryBoyModel>>> getAllDelivaryBoy(
      {required String filter});
  Future<Either<CleanFailure, Unit>> createDelivaryBoy(
      {required CreateDelivaryBoyModel delivaryBoy});
  Future<Either<CleanFailure, Unit>> updateDelivaryBoy(
      {required CreateDelivaryBoyModel delivaryBoy, required int id});
  Future<Either<CleanFailure, DelivaryBoyModel>> getDelivaryBoyDetails(
      {required int delivaryBoyId});
  Future<Either<CleanFailure, Unit>> trashDelivaryBoy(
      {required int delivaryBoyId});
  Future<Either<CleanFailure, Unit>> restoreDelivaryBoy(
      {required int delivaryBoyId});
  Future<Either<CleanFailure, Unit>> deleteDelivaryBoy(
      {required int delivaryBoyId});
}
