import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/catalog/atributes/atributes_model.dart';
import 'package:zcart_seller/domain/app/catalog/atributes/attribute_type_model.dart';
import 'package:zcart_seller/domain/app/catalog/atributes/categories_model.dart';
import 'package:zcart_seller/domain/app/catalog/atributes/get_atributes_model.dart/get_atributes_model.dart';

abstract class IAtributesRepo {
  Future<Either<CleanFailure, List<AtributesModel>>> getAtributes(
      {required String filter});

  Future<Either<CleanFailure, GetAtributesModel>> getAlAtributes(
      {required int attributeId});

  Future<Either<CleanFailure, Unit>> createAtributes(
      {required String name,
      required String attributeTypeId,
      required String categoriesIds,
      required String order});

  Future<Either<CleanFailure, Unit>> updateAtributes(
      {required attributeId,
      required name,
      required attributeTypeId,
      required categoriesIds,
      required order});

  Future<Either<CleanFailure, Unit>> trashAttributes(
      {required int attributeId});

  Future<Either<CleanFailure, Unit>> restoreAttributes(
      {required int attributeId});

  Future<Either<CleanFailure, Unit>> deleteAttributes(
      {required int attributeId});

  Future<Either<CleanFailure, List<AttributeTypeModel>>> getAttributesTypes();
  Future<Either<CleanFailure, List<CategoriesModel>>> getCategories();
}
