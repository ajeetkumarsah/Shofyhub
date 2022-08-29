import 'package:clean_api/clean_api.dart';
import 'package:zcart_vendor/domain/auth/log_in_body.dart';
import 'package:zcart_vendor/domain/auth/user_model.dart';

abstract class IAuthRepo {
  Future<Either<CleanFailure, UserModel>> logIn({required LogInBody body});
}
