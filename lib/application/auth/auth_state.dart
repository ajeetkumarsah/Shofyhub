// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:zcart_vendor/domain/auth/user_model.dart';

class AuthState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final UserModel user;
  const AuthState({
    required this.loading,
    required this.failure,
    required this.user,
  });

  AuthState copyWith({
    bool? loading,
    CleanFailure? failure,
    UserModel? user,
  }) {
    return AuthState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      user: user ?? this.user,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [loading, failure, user];

  factory AuthState.init() => AuthState(
      loading: false, failure: CleanFailure.none(), user: UserModel.init());
}
