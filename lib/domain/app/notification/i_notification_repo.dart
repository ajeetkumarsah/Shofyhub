import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/notification/notification_model.dart';

abstract class INotificationRepo {
  Future<Either<CleanFailure, List<NotificationModel>>> getNotifications();
  Future<Either<CleanFailure, Unit>> postFcmToken({required String token});
}
