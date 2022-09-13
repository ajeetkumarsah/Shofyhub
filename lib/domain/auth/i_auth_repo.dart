import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/auth/log_in_body.dart';
import 'package:zcart_seller/domain/auth/registration_body.dart';
import 'package:zcart_seller/domain/auth/user_model.dart';

abstract class IAuthRepo {
  Future<Either<CleanFailure, UserModel>> logIn({required LogInBody body});
  Future<Either<CleanFailure, UserModel>> registration(
      {required RegistrationBody body});
  Future<Either<CleanFailure, Unit>> forgetPassword({required String email});
}
