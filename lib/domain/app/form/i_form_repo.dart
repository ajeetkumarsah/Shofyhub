import 'package:clean_api/clean_api.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:zcart_seller/domain/app/form/key_value_data.dart';

abstract class IFormRepo {
  Future<Either<CleanFailure, IList<KeyValueData>>> getCategoriesList();
  Future<Either<CleanFailure, IList<KeyValueData>>> getAttributesList();
  Future<Either<CleanFailure, IList<KeyValueData>>> getManufacturerList();
  Future<Either<CleanFailure, IList<KeyValueData>>> getCountryList();
  Future<Either<CleanFailure, IList<KeyValueData>>> getInvetoryList();
  Future<Either<CleanFailure, IList<KeyValueData>>> getItemCondition();
  Future<Either<CleanFailure, IList<KeyValueData>>> getOrderStatus();
  Future<Either<CleanFailure, IList<KeyValueData>>> getseotag();
  Future<Either<CleanFailure, IList<KeyValueData>>> getShop();
  Future<Either<CleanFailure, IList<KeyValueData>>> getPlans();
  Future<Either<CleanFailure, IList<KeyValueData>>> getBusinessDays();
  Future<Either<CleanFailure, IList<KeyValueData>>> getStateList(
      {required int id});
}
