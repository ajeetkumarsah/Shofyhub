import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/application/app/support/live_chat/conversession_state.dart';
import 'package:alpesportif_seller/domain/app/support/live_chat/i_conversession_repo.dart';
import 'package:alpesportif_seller/infrastructure/app/support/live_chat/conversession_repo.dart';

final conversessionProvider =
    StateNotifierProvider<ConversessionNotifier, ConversessionState>((ref) {
  return ConversessionNotifier(ConversessionRepo());
});

class ConversessionNotifier extends StateNotifier<ConversessionState> {
  final IConversessionRepo conversessionRepo;
  ConversessionNotifier(this.conversessionRepo)
      : super(ConversessionState.init());

  getAllConversessions() async {
    state = state.copyWith(loading: true);
    final data = await conversessionRepo.getAllConversessions();
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false,
            failure: CleanFailure.none(),
            conversessionList: r));
  }

  getConversessionDetails({required int customerId}) async {
    state = state.copyWith(loading: true);
    final data =
        await conversessionRepo.getConversessionDetails(customerId: customerId);
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false,
            failure: CleanFailure.none(),
            conversessionDetails: r));
  }

  replyConversession({required int customerId, required String message}) async {
    state = state.copyWith(loading: true);
    final data = await conversessionRepo.replyConversession(
        customerId: customerId, message: message);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getAllConversessions();
    getConversessionDetails(customerId: customerId);
  }
}
