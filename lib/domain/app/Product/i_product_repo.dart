import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/Product/product_pagination_model.dart';
import 'package:zcart_seller/domain/app/product/create_product/gtin_types_model.dart';
import 'package:zcart_seller/domain/app/product/create_product/update_product_model.dart';
import 'create_product/manufacturer_id.dart';
import 'create_product/tag_list.dart';

abstract class IProductRepo {
  Future<Either<CleanFailure, ProductPaginationModel>> getProducts(
      {required String productFilter, required int page});

  Future<Either<CleanFailure, Unit>> trashProduct(int productId);
  Future<Either<CleanFailure, String>> createProduct(formData);
  Future<Either<CleanFailure, Unit>> updateProduct({
    required UpdateProductModel updateDetails,
  });
  Future<Either<CleanFailure, Unit>> restoreProduct({required productId});
  Future<Either<CleanFailure, Unit>> deleteProduct({required productId});
  Future<Either<CleanFailure, List<GtinTypes>>> gtinType();
  Future<Either<CleanFailure, List<TagListModel>>> tagList();
  Future<Either<CleanFailure, List<ManufacturerId>>> manufacturer();
}
