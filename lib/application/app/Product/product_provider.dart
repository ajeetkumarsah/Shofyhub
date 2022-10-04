import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/product/product_state.dart';
import 'package:zcart_seller/domain/app/Product/product_pagination_model.dart';
import 'package:zcart_seller/domain/app/product/create_product/create_product_model.dart';
import 'package:zcart_seller/domain/app/product/create_product/update_product_model.dart';
import 'package:zcart_seller/domain/app/product/product_model.dart';
import 'package:zcart_seller/infrastructure/app/Products/product_repo.dart';

import '../../../domain/app/product/i_product_repo.dart';

final productProvider =
    StateNotifierProvider<ProductNotifier, ProductState>((ref) {
  return ProductNotifier(ProductRepo());
});

class ProductNotifier extends StateNotifier<ProductState> {
  final IProductRepo productRepo;
  ProductNotifier(this.productRepo) : super(ProductState.init());

  ProductPaginationModel productPaginationModel = ProductPaginationModel.init();
  List<ProductModel> products = [];
  int pageNumber = 1;

  getProducts() async {
    pageNumber = 1;
    products = [];

    state = state.copyWith(loading: true);
    final data = await productRepo.getProducts(page: pageNumber);

    //increase the page no
    pageNumber++;

    state = data.fold((l) => state.copyWith(loading: false, failure: l), (r) {
      productPaginationModel = r;

      products.addAll(productPaginationModel.data);

      return state.copyWith(
        loading: false,
        productList: products,
        failure: CleanFailure.none(),
      );
    });
  }

  getMoreProducts() async {
    if (pageNumber == 1 ||
        pageNumber <= productPaginationModel.meta.lastPage!) {
      final data = await productRepo.getProducts(page: pageNumber);

      //increase the page no
      pageNumber++;

      state = data.fold((l) => state.copyWith(loading: false, failure: l), (r) {
        productPaginationModel = r;

        products.addAll(productPaginationModel.data);

        return state.copyWith(
          loading: false,
          productList: products,
          failure: CleanFailure.none(),
        );
      });
    }
  }

  deleteProduct(int productId) async {
    state = state.copyWith(loading: true);
    await productRepo.deleteProduct(productId);
    state = state.copyWith(loading: false);
    getProducts();
  }

  updateProduct(UpdateProductModel updateDetails) async {
    state = state.copyWith(loading: true);
    final data = await productRepo.updateProduct(
      updateDetails: updateDetails,
    );
    state = data.fold(
      (l) => state.copyWith(loading: false, failure: l),
      (r) => state.copyWith(
        loading: false,
        failure: CleanFailure.none(),
      ),
    );
    getProducts();
  }

  createProduct(CreateProductModel createProduct) async {
    state = state.copyWith(loading: true);
    final data = await productRepo.createProduct(createProduct);
    state = data.fold(
      (l) => state.copyWith(loading: false, failure: l),
      (r) => state.copyWith(
        loading: false,
        failure: CleanFailure.none(),
      ),
    );
    getProducts();
  }

  gtinType() async {
    state = state.copyWith(loading: true);
    final data = await productRepo.gtinType();
    state = data.fold(
      (l) => state.copyWith(loading: false, failure: l),
      (r) => state.copyWith(
        loading: false,
        failure: CleanFailure.none(),
        gtinTypes: r,
      ),
    );
  }

  tagList() async {
    state = state.copyWith(loading: true);
    final data = await productRepo.tagList();
    state = data.fold(
      (l) => state.copyWith(loading: false, failure: l),
      (r) => state.copyWith(
        loading: false,
        failure: CleanFailure.none(),
        tagList: r,
      ),
    );
  }

  manufacturer() async {
    state = state.copyWith(loading: true);
    final data = await productRepo.manufacturer();
    state = data.fold(
      (l) => state.copyWith(loading: false, failure: l),
      (r) => state.copyWith(
        loading: false,
        failure: CleanFailure.none(),
        manufacturerId: r,
      ),
    );
  }
}
