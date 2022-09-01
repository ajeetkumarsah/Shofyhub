import 'package:clean_api/clean_api.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:zcart_seller/domain/app/form/i_form_repo.dart';
import 'package:zcart_seller/domain/app/form/key_value_data.dart';

class FormRepo extends IFormRepo {
  final CleanApi api = CleanApi.instance;
  @override
  Future<Either<CleanFailure, IList<KeyValueData>>>
      getManufacturerList() async {
    return await api.get(
        fromData: (data) => KeyValueData.listFromMap(data),
        endPoint: 'data/manufacturers');
  }

  @override
  Future<Either<CleanFailure, IList<KeyValueData>>> getCountryList() async {
    return await api.get(
        fromData: (data) => KeyValueData.listFromMap(data),
        endPoint: 'data/countries');
  }
}
