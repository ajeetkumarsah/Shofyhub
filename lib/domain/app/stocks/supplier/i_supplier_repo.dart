import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/stocks/supplier/supplier_pagination_model.dart';

abstract class ISupplierRepo {
  Future<Either<CleanFailure, SupplierPaginationModel>> getSuppliers(
      {required String supplierFilter, required int page});
  Future<Either<CleanFailure, Unit>> trashSupplier({required int supplierId});
  Future<Either<CleanFailure, Unit>> restoreSupplier({required supplierId});
  Future<Either<CleanFailure, Unit>> deleteSupplier({required supplierId});
  // Future<Either<CleanFailure, Unit>> deleteSuppliers(int supplierId);
  // Future<Either<CleanFailure, Unit>> createSuppliers(CreateSupplierModel body);
  // Future<Either<CleanFailure, Unit>> updateSupplier({
  //   required UpdateSupplierModel updateDetails,
  // });
}
