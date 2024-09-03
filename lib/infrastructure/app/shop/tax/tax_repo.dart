import 'package:clean_api/clean_api.dart';
import 'package:alpesportif_seller/domain/app/shop/taxes/create_tax_model.dart';

import 'package:alpesportif_seller/domain/app/shop/taxes/i_tax_repo.dart';
import 'package:alpesportif_seller/domain/app/shop/taxes/tax_model.dart';

class TaxRepo extends ITaxRepo {
  final cleanApi = CleanApi.instance;
  @override
  Future<Either<CleanFailure, Unit>> createNewTax(
      {required CreateTaxModel taxInfo}) async {
    return cleanApi.post(
      fromData: (json) => unit,
      body: null,
      endPoint:
          'tax/create?name=${taxInfo.name}&taxrate=${taxInfo.taxrate}&active=${taxInfo.active}&country_id=${taxInfo.countryId}&state_id=${taxInfo.stateId}',
    );
  }

  @override
  Future<Either<CleanFailure, Unit>> deleteTax({required int taxId}) async {
    return cleanApi.delete(
        fromData: (json) => unit, endPoint: 'tax/$taxId/delete');
  }

  @override
  Future<Either<CleanFailure, List<TaxModel>>> getAllTax(
      {required String filter}) async {
    return cleanApi.get(
        fromData: ((json) =>
            List<TaxModel>.from(json['data'].map((e) => TaxModel.fromMap(e)))),
        endPoint: 'taxes?filter=$filter');
  }

  @override
  Future<Either<CleanFailure, TaxModel>> getTaxDetails(
      {required int taxId}) async {
    return cleanApi.get(
        fromData: (json) => TaxModel.fromMap(json['data']),
        endPoint: 'tax/$taxId');
  }

  @override
  Future<Either<CleanFailure, Unit>> restoreTax({required int taxId}) async {
    return cleanApi.put(
        fromData: (json) => unit, body: null, endPoint: 'tax/$taxId/restore');
  }

  @override
  Future<Either<CleanFailure, Unit>> trashTax({required int taxId}) async {
    return cleanApi.delete(
        fromData: (json) => unit, endPoint: 'tax/$taxId/trash');
  }

  @override
  Future<Either<CleanFailure, Unit>> updateTax(
      {required CreateTaxModel taxInfo, required int taxId}) async {
    return cleanApi.put(
      fromData: (josn) => unit,
      body: null,
      endPoint:
          'tax/$taxId/update?name=${taxInfo.name}&taxrate=${taxInfo.taxrate}&active=${taxInfo.active}&country_id=${taxInfo.countryId}&state_id=${taxInfo.stateId}',
    );
  }
}
