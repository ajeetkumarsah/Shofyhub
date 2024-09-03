import 'dart:developer';

import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alpesportif_seller/application/auth/auth_state.dart';
import 'package:alpesportif_seller/domain/auth/i_auth_repo.dart';
import 'package:alpesportif_seller/domain/auth/log_in_body.dart';
import 'package:alpesportif_seller/domain/auth/registration_body.dart';
import 'package:alpesportif_seller/domain/auth/user_model.dart';
import 'package:alpesportif_seller/infrastructure/auth/auth_repo.dart';

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

  registration({required RegistrationBody body}) async {
    state = state.copyWith(loading: true);
    final data = await authRepo.registration(body: body);
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), user: r));
    Logger.i(state.user);
  }

  otpLogin({required String phone}) async {
    state = state.copyWith(loading: true);
    final data = await authRepo.otpLogin(phoneNumber: phone);
    log('otplogin provider: $data');
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(state.user);
  }

  otpVerify({required String phone, required String code}) async {
    state = state.copyWith(loading: true);
    final data = await authRepo.otpVerify(phoneNumber: phone, code: code);
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), user: r));
    Logger.i(state.user);
  }

  forgetPassword({required String email}) async {
    state = state.copyWith(loading: true);
    final data = await authRepo.forgetPassword(email: email);
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
              loading: false,
              failure: CleanFailure.none(),
            ));
  }

  logout() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString('token', '');
    state = state.copyWith(
      loading: false,
      failure: CleanFailure.none(),
      user: UserModel.init(),
    );
    Logger.i(state.user);
  }
}
