import 'package:clean_api/clean_api.dart';
import 'package:alpesportif_seller/domain/app/notification/i_notification_repo.dart';
import 'package:alpesportif_seller/domain/app/notification/notification_model.dart';

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

  @override
  Future<Either<CleanFailure, List<NotificationModel>>> getNotifications() {
    return cleanApi.get(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'notifications', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'notifications',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'notifications',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(CleanFailure(
                tag: 'notifications', error: responseBody.toString()));
          }
        },
        fromData: ((json) => List<NotificationModel>.from(
            json["data"].map((x) => NotificationModel.fromMap(x)))),
        endPoint: 'notifications');
  }
}
