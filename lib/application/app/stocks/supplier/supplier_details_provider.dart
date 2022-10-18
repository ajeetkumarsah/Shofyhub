import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/stocks/supplier/supplier_details_state.dart';
import 'package:zcart_seller/domain/app/stocks/supplier/i_supplier_repo.dart';
import 'package:zcart_seller/infrastructure/app/stocks/supplier/supplier_repo.dart';

final supplierDetailsProvider =
    StateNotifierProvider<SupplierDetailsNotifier, SupplierDetailsState>((ref) {
  return SupplierDetailsNotifier(SupplierRepo());
});

class SupplierDetailsNotifier extends StateNotifier<SupplierDetailsState> {
  final ISupplierRepo supplierRepo;

  SupplierDetailsNotifier(this.supplierRepo)
      : super(SupplierDetailsState.init());

  getSupplierDetails({required int supplierId}) async {
    state = state.copyWith(loading: true);
    final data = await supplierRepo.getSupplierDetails(supplierId: supplierId);
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), supplierDetails: r));
  }
}
