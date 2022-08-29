import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_vendor/application/auth/auth_state.dart';
import 'package:zcart_vendor/domain/auth/i_auth_repo.dart';
import 'package:zcart_vendor/domain/auth/log_in_body.dart';
import 'package:zcart_vendor/infrastructure/auth/auth_repo.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(AuthRepo());
});

class AuthNotifier extends StateNotifier<AuthState> {
  final IAuthRepo authRepo;
  AuthNotifier(this.authRepo) : super(AuthState.init());

  login({required LogInBody body}) async {
    state = state.copyWith(loading: true);
    final data = await authRepo.logIn(body: body);
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), user: r));
    Logger.i(state.user);
  }
}
