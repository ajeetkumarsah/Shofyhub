import 'package:clean_api/clean_api.dart';
import 'package:alpesportif_seller/domain/app/shop/taxes/create_tax_model.dart';
import 'package:alpesportif_seller/domain/app/shop/taxes/tax_model.dart';

abstract class ITaxRepo {
  Future<Either<CleanFailure, List<TaxModel>>> getAllTax(
      {required String filter});
  Future<Either<CleanFailure, TaxModel>> getTaxDetails({required int taxId});
  Future<Either<CleanFailure, Unit>> createNewTax(
      {required CreateTaxModel taxInfo});
  Future<Either<CleanFailure, Unit>> updateTax(
      {required CreateTaxModel taxInfo, required int taxId});
  Future<Either<CleanFailure, Unit>> trashTax({required int taxId});
  Future<Either<CleanFailure, Unit>> restoreTax({required int taxId});
  Future<Either<CleanFailure, Unit>> deleteTax({required int taxId});
}
