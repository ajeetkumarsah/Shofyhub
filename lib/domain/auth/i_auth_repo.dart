import 'package:clean_api/clean_api.dart';
import 'package:alpesportif_seller/domain/auth/log_in_body.dart';
import 'package:alpesportif_seller/domain/auth/registration_body.dart';
import 'package:alpesportif_seller/domain/auth/user_model.dart';

abstract class IAuthRepo {
  Future<Either<CleanFailure, UserModel>> logIn({required LogInBody body});
  Future<Either<CleanFailure, UserModel>> registration(
      {required RegistrationBody body});
  Future<Either<CleanFailure, Unit>> forgetPassword({required String email});
  Future<Either<CleanFailure, Unit>> otpLogin({required String phoneNumber});
  Future<Either<CleanFailure, UserModel>> otpVerify(
      {required String phoneNumber, required String code});
}
