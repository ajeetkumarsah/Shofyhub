import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/shop/taxes/tax_state.dart';
import 'package:zcart_seller/domain/app/shop/taxes/create_tax_model.dart';
import 'package:zcart_seller/domain/app/shop/taxes/i_tex_repo.dart';

class TaxNotifier extends StateNotifier<TaxState> {
  final ITaxRepo taxRepo;
  TaxNotifier(this.taxRepo) : super(TaxState.init());

  getAllTax() async {
    state = state.copyWith(loading: true);
    final data = await taxRepo.getAllTax();
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), taxList: r));
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
  }

  updateTax({required CreateTaxModel taxInfo, required int taxId}) async {
    state = state.copyWith(loading: true);
    final data = await taxRepo.updateTax(taxInfo: taxInfo, taxId: taxId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
  }

  trashTax({required int taxId}) async {
    state = state.copyWith(loading: true);
    final data = await taxRepo.trashTax(taxId: taxId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
  }

  restoreTax({required int taxId}) async {
    state = state.copyWith(loading: true);
    final data = await taxRepo.restoreTax(taxId: taxId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
  }

  deleteTax({required int taxId}) async {
    state = state.copyWith(loading: true);
    final data = await taxRepo.deleteTax(taxId: taxId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
  }
}
