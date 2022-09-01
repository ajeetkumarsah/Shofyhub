import 'package:clean_api/clean_api.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:zcart_seller/domain/app/form/key_value_data.dart';

abstract class IFormRepo {
  Future<Either<CleanFailure, IList<KeyValueData>>> getManufacturerList();
  Future<Either<CleanFailure, IList<KeyValueData>>> getCountryList();
}
