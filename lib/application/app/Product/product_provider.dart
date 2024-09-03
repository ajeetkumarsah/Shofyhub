import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/application/app/product/product_state.dart';
import 'package:alpesportif_seller/domain/app/Product/product_pagination_model.dart';
import 'package:alpesportif_seller/domain/app/product/product_model.dart';
import 'package:alpesportif_seller/infrastructure/app/Products/product_repo.dart';

import '../../../domain/app/product/i_product_repo.dart';

final productProvider =
    StateNotifierProvider<ProductNotifier, ProductState>((ref) {
  return ProductNotifier(ProductRepo());
});

class ProductNotifier extends StateNotifier<ProductState> {
  final IProductRepo productRepo;
  ProductNotifier(this.productRepo) : super(ProductState.init());

  ProductPaginationModel productPaginationModel = ProductPaginationModel.init();
  ProductPaginationModel trashProductPaginationModel =
      ProductPaginationModel.init();

  List<ProductModel> products = [];
  int pageNumber = 1;

  List<ProductModel> trashProducts = [];
  int trashPageNumber = 1;

  getProducts() async {
    pageNumber = 1;
    products = [];

    state = state.copyWith(loading: true);
    final data =
        await productRepo.getProducts(productFilter: 'null', page: pageNumber);

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
      final data = await productRepo.getProducts(
          productFilter: 'null', page: pageNumber);

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

  getTrashProducts() async {
    trashPageNumber = 1;
    trashProducts = [];

    state = state.copyWith(loading: true);

    //increase the page no
    trashPageNumber++;
    final suppliersData =
        await productRepo.getProducts(productFilter: 'trash', page: 1);

    state = suppliersData
        .fold((l) => state.copyWith(loading: false, failure: l), (r) {
      trashProductPaginationModel = r;
      trashProducts.addAll(trashProductPaginationModel.data);

      return state.copyWith(
        loading: false,
        failure: CleanFailure.none(),
        trashProductList: trashProducts,
      );
    });
  }

  // getMoreTrashProducts() async {
  //   if (trashPageNumber == 1 ||
  //       trashPageNumber <= productPaginationModel.meta.lastPage!) {
  //     final data = await productRepo.getProducts(
  //         productFilter: 'trash', page: trashPageNumber);

  //     //increase the page no
  //     trashPageNumber++;

  //     state = data.fold((l) => state.copyWith(loading: false, failure: l), (r) {
  //       productPaginationModel = r;
  //       trashProducts.addAll(productPaginationModel.data);

  //       return state.copyWith(
  //           loading: false,
  //           failure: CleanFailure.none(),
  //           trashProductList: trashProducts);
  //     });
  //   }
  // }

  trashProduct(int productId) async {
    state = state.copyWith(loading: true);
    await productRepo.trashProduct(productId);
    state = state.copyWith(loading: false);
    getProducts();
    getTrashProducts();
  }

  updateProduct(id, formData) async {
    state = state.copyWith(loading: true);
    final data = await productRepo.updateProduct(
      id: id,
      formData: formData,
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

  createProduct(formData) async {
    state = state.copyWith(loading: true);
    final data = await productRepo.createProduct(formData);
    state = data.fold(
      (l) => state.copyWith(loading: false, failure: l),
      (r) => state.copyWith(
        loading: false,
        failure: CleanFailure.none(),
      ),
    );
    getProducts();
  }

  restoreProduct(int productId) async {
    state = state.copyWith(loading: true);
    final quickUpdateData =
        await productRepo.restoreProduct(productId: productId);

    state = quickUpdateData.fold(
      (l) => state.copyWith(loading: false, failure: l),
      (r) => state.copyWith(loading: false, failure: CleanFailure.none()),
    );
    getProducts();
    getTrashProducts();
  }

  deleteProduct(int productId) async {
    state = state.copyWith(loading: true);
    final quickUpdateData =
        await productRepo.deleteProduct(productId: productId);

    state = quickUpdateData.fold(
      (l) => state.copyWith(loading: false, failure: l),
      (r) => state.copyWith(loading: false, failure: CleanFailure.none()),
    );
    getProducts();
    getTrashProducts();
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
