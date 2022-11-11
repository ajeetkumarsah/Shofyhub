import 'package:clean_api/clean_api.dart';

abstract class INotificationRepo {
  Future<Either<CleanFailure, Unit>> postFcmToken({required String token});
}
