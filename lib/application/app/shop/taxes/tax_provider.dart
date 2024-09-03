import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/application/app/shop/taxes/tax_state.dart';
import 'package:alpesportif_seller/domain/app/shop/taxes/create_tax_model.dart';
import 'package:alpesportif_seller/domain/app/shop/taxes/i_tax_repo.dart';
import 'package:alpesportif_seller/infrastructure/app/shop/tax/tax_repo.dart';

final taxProvider = StateNotifierProvider<TaxNotifier, TaxState>((ref) {
  return TaxNotifier(TaxRepo());
});

class TaxNotifier extends StateNotifier<TaxState> {
  final ITaxRepo taxRepo;
  TaxNotifier(this.taxRepo) : super(TaxState.init());

  getAllTax() async {
    state = state.copyWith(loading: true);
    final data = await taxRepo.getAllTax(filter: 'null');
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), taxList: r));
  }

  getTrashTax() async {
    state = state.copyWith(loading: true);
    final data = await taxRepo.getAllTax(filter: 'trash');
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), trashTaxList: r));
  }

  getTaxDetails({required int taxId}) async {
    state = state.copyWith(loading: true);
    final data = await taxRepo.getTaxDetails(taxId: taxId);
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), taxDetails: r));
  }

  createNewTAx({required CreateTaxModel taxInfo}) async {
    state = state.copyWith(loading: true);
    final data = await taxRepo.createNewTax(taxInfo: taxInfo);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getAllTax();
  }

  updateTax({required CreateTaxModel taxInfo, required int taxId}) async {
    state = state.copyWith(loading: true);
    final data = await taxRepo.updateTax(taxInfo: taxInfo, taxId: taxId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getAllTax();
  }

  trashTax({required int taxId}) async {
    state = state.copyWith(loading: true);
    final data = await taxRepo.trashTax(taxId: taxId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getAllTax();
    getTrashTax();
  }

  restoreTax({required int taxId}) async {
    state = state.copyWith(loading: true);
    final data = await taxRepo.restoreTax(taxId: taxId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getAllTax();
    getTrashTax();
  }

  deleteTax({required int taxId}) async {
    state = state.copyWith(loading: true);
    final data = await taxRepo.deleteTax(taxId: taxId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getAllTax();
    getTrashTax();
  }
}
