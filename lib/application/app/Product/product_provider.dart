import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_vendor/application/app/Product/product_state.dart';
import 'package:zcart_vendor/domain/app/Product/create_product/create_product_model.dart';
import 'package:zcart_vendor/infrastructure/app/Products/product_repo.dart';

import '../../../domain/app/Product/i_product_repo.dart';

final productProvider =
    StateNotifierProvider<ProductNotifier, ProductState>((ref) {
  return ProductNotifier(ProductRepo());
});

class ProductNotifier extends StateNotifier<ProductState> {
  final IProductRepo productRepo;
  ProductNotifier(this.productRepo) : super(ProductState.init());
  getProducts() async {
    state = state.copyWith(loading: true);
    final data = await productRepo.getProducts();
    state = data.fold(
      (l) => state.copyWith(loading: false, failure: l),
      (r) => state.copyWith(
        loading: false,
        productList: r,
        failure: CleanFailure.none(),
      ),
    );
  }

  deleteProduct(int productId) async {
    await productRepo.deleteProduct(productId);
    getProducts();
  }

  updateProduct(CreateProductModel updateDetails) async {
    state = state.copyWith(loading: true);
    final data = await productRepo.updateProduct(updateDetails: updateDetails);
    state = data.fold(
      (l) => state.copyWith(loading: false, failure: l),
      (r) => state.copyWith(
        loading: false,
        failure: CleanFailure.none(),
      ),
    );
  }
}
