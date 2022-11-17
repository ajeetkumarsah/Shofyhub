import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/catalog/attribute%20values/attribute_value_details_model/attribute_value_details_model.dart';
import 'package:zcart_seller/domain/app/catalog/attribute%20values/attribute_values_model.dart';

abstract class IAttributeValuesRepo {
  Future<Either<CleanFailure, List<AttributeValuesModel>>> getAttributeValues(
      {required int attributeId, required String filter});

  Future<Either<CleanFailure, AttributeValueDetailsModel>>
      getAttributeValueDetails({required int attributeValueId});

  Future<Either<CleanFailure, Unit>> createAttributeValue(
      {required String value,
      required int attributeId,
      required String color,
      required int order});

  Future<Either<CleanFailure, Unit>> updateAttributeValue(
      {required int attributeValueId,
      required String value,
      required String color,
      required int attributeId,
      required int order});

  Future<Either<CleanFailure, Unit>> trashAttributeValue(
      {required int attributeValueId});

  Future<Either<CleanFailure, Unit>> restoreAttributeValue(
      {required int attributeValueId});

  Future<Either<CleanFailure, Unit>> deleteAttributeValue(
      {required int attributeValueId});
}
