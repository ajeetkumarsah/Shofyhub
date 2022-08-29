import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_vendor/application/app/Product/detail_product/detail_product_state.dart';
import 'package:zcart_vendor/domain/app/Product/Detail%20Product/detail_product_model.dart';
import 'package:zcart_vendor/domain/app/Product/Detail%20Product/i_detail_product_repo.dart';

class DetailProductNotifier extends StateNotifier<DetailProductState> {
  final IDetailProductRepo detailProduct;
  DetailProductNotifier(this.detailProduct) : super(DetailProductState.init());
  getDetailProduct() async {
    state = state.copyWith(loading: true);
    final data = await detailProduct.getDetailProduct(
        productId: DetailProductModel.init());
    state = state.copyWith(loading: true);
    state = data.fold(
      (l) => state.copyWith(loading: false, failure: l),
      (r) => state.copyWith(
          loading: false, detailProduct: r, failure: CleanFailure.none()),
    );
  }
}
