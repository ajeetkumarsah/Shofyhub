import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/notification/i_notification_repo.dart';

class NotificationRepo extends INotificationRepo {
  final cleanApi = CleanApi.instance;

  @override
  Future<Either<CleanFailure, Unit>> postFcmToken({required String token}) {
    return cleanApi.post(
      fromData: (json) => unit,
      body: null,
      endPoint: 'fcm_token/create?token=$token',
    );
  }
}
