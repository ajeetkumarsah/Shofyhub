import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/notification/notification_data_state.dart';
import 'package:zcart_seller/domain/app/notification/i_notification_repo.dart';
import 'package:zcart_seller/domain/app/notification/notification_model.dart';
import 'package:zcart_seller/infrastructure/app/notification/notification_repo.dart';

final notificationDataProvider =
    StateNotifierProvider<NotificationDataNotifier, NotificationDataState>(
        (ref) {
  return NotificationDataNotifier(NotificationRepo());
});

class NotificationDataNotifier extends StateNotifier<NotificationDataState> {
  final INotificationRepo notificationRepo;
  NotificationDataNotifier(this.notificationRepo)
      : super(NotificationDataState.init());

  List<NotificationModel> notifications = [];

  getNotifications() async {
    state = state.copyWith(loading: true);
    final data = await notificationRepo.getNotifications();

    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, notificationList: r, failure: CleanFailure.none()));
  }
}
