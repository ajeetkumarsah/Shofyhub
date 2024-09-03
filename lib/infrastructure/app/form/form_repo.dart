import 'package:clean_api/clean_api.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:alpesportif_seller/domain/app/form/i_form_repo.dart';
import 'package:alpesportif_seller/domain/app/form/key_value_data.dart';

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
  Future<Either<CleanFailure, IList<KeyValueData>>> getCategoriesList() async {
    return await api.get(
        fromData: (data) => KeyValueData.listFromMap(data),
        endPoint: 'data/categories');
  }

  @override
  Future<Either<CleanFailure, IList<KeyValueData>>> getCountryList() async {
    return await api.get(
        fromData: (data) => KeyValueData.listFromMap(data),
        endPoint: 'data/countries');
  }

  @override
  Future<Either<CleanFailure, IList<KeyValueData>>> getInvetoryList() async {
    return await api.get(
        fromData: (data) => KeyValueData.listFromMap(data),
        endPoint: 'data/inventories');
  }

  @override
  Future<Either<CleanFailure, IList<KeyValueData>>> getItemCondition() async {
    return await api.get(
        fromData: (data) => KeyValueData.listFromMap(data),
        endPoint: 'data/item_conditions');
  }

  @override
  Future<Either<CleanFailure, IList<KeyValueData>>> getOrderStatus() async {
    return await api.get(
        fromData: (data) => KeyValueData.listFromMap(data),
        endPoint: 'data/order_statuses');
  }

  @override
  Future<Either<CleanFailure, IList<KeyValueData>>> getseotag() async {
    return await api.get(
        fromData: (data) => KeyValueData.listFromMap(data),
        endPoint: 'data/seo_tags');
  }

  @override
  Future<Either<CleanFailure, IList<KeyValueData>>> getShop() async {
    return await api.get(
        fromData: (data) => KeyValueData.listFromMap(data),
        endPoint: 'data/shops');
  }

  @override
  Future<Either<CleanFailure, IList<KeyValueData>>> getPlans() async {
    return await api.get(
        fromData: (data) => KeyValueData.listFromMap(data),
        endPoint: 'data/subscription_plans');
  }

  @override
  Future<Either<CleanFailure, IList<KeyValueData>>> getStateList(
      {required int id}) async {
    return await api.get(
        fromData: (data) => KeyValueData.listFromMap(data),
        endPoint: 'data/states/$id');
  }

  @override
  Future<Either<CleanFailure, IList<KeyValueData>>> getAttributesList() async {
    return await api.get(
        fromData: (data) => KeyValueData.listFromMap(data),
        endPoint: 'data/attributes');
  }

  @override
  Future<Either<CleanFailure, IList<KeyValueData>>> getBusinessDays() async {
    return await api.get(
        fromData: (data) => KeyValueData.listFromMap(data),
        endPoint: 'data/business_days');
  }
}
