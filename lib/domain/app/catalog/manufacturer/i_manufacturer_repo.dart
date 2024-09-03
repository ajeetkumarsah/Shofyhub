import 'package:clean_api/clean_api.dart';
import 'package:alpesportif_seller/domain/app/catalog/manufacturer/manufacturer_details_model.dart';
import 'package:alpesportif_seller/domain/app/catalog/manufacturer/manufacturer_pagination_model.dart';

abstract class IManufacturerRepo {
  Future<Either<CleanFailure, ManufacturerPaginationModel>> getManufacturerList(
      {required String filter, required int page});
  Future<Either<CleanFailure, ManufacturerDetailsModel>> getManufacturerDetails(
      {required int manufacturerId});
  Future<Either<CleanFailure, String>> createManufacturer(formData);
  Future<Either<CleanFailure, String>> updateManufacturer(
      {required int manufacturerId, required formData});
  Future<Either<CleanFailure, Unit>> trashManufacturer(
      {required int manufacturerId});
  Future<Either<CleanFailure, Unit>> restoreManufacturer(
      {required int manufacturerId});
  Future<Either<CleanFailure, Unit>> deleteManufacturer(
      {required int manufacturerId});
}
