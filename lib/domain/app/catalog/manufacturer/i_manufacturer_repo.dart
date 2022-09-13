import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/catalog/manufacturer/manufacturer_details_model.dart';
import 'package:zcart_seller/domain/app/catalog/manufacturer/manufacturer_model.dart';

abstract class IManufacturerRepo {
  Future<Either<CleanFailure, List<ManufacturerModel>>> getManufacturerList();
  Future<Either<CleanFailure, ManufacturerDetailsModel>> getManufacturerDetails(
      {required int manufacturerId});
  Future<Either<CleanFailure, Unit>> createManufacturer(
      {required String name,
      required String slug,
      required String url,
      required bool active,
      required String countryId,
      required String email,
      required String phone,
      required String description});
  Future<Either<CleanFailure, Unit>> updateManufacturer(
      {required int manufacturerId,
      required String name,
      required String slug,
      required String url,
      required bool active,
      required String countryId,
      required String email,
      required String phone,
      required String description});
  Future<Either<CleanFailure, Unit>> trashManufacturer(
      {required int manufacturerId});
  Future<Either<CleanFailure, Unit>> restoreManufacturer(
      {required int manufacturerId});
  Future<Either<CleanFailure, Unit>> deleteManufacturer(
      {required int manufacturerId});
}
