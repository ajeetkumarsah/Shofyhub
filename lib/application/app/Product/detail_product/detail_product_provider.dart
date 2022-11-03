  

import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/product/detail_product/detail_product_state.dart';
import 'package:zcart_seller/domain/app/product/detail_product/i_detail_product_repo.dart';
import 'package:zcart_seller/infrastructure/app/detail_product/detail_product_repo.dart';

final detailProcuctProvider = StateNotifierProvider.family<
    DetailProductNotifier, DetailProductState, int>((ref, id) {
  return DetailProductNotifier(repo: DetailProductRepo(), productId: id);
});

class DetailProductNotifier extends StateNotifier<DetailProductState> {
  final int productId;
  final IDetailProductRepo repo;
  DetailProductNotifier({required this.repo, required this.productId})
      : super(DetailProductState.init());
  getDetailProduct() async {
    state = state.copyWith(loading: true);
    final data = await repo.getDetailProduct(productId: productId);
    state = state.copyWith(loading: true);
    state = data.fold(
      (l) => state.copyWith(loading: false, failure: l),
      (r) => state.copyWith(
          loading: false, detailProduct: r, failure: CleanFailure.none()),
    );
  }
}
