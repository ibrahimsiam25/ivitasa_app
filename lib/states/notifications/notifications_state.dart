part of 'notifications_bloc.dart';

final class NotificationsState extends Equatable {
  const NotificationsState({
    required this.notifications,
    this.isLoading = false,
  });
  final bool isLoading;
  final List<Notification> notifications;
  factory NotificationsState.loading() => NotificationsState(
        isLoading: true,
        notifications: [],
      );
  factory NotificationsState.initial(List<Notification> notifications) => NotificationsState(
        isLoading: false,
        notifications: notifications,
      );

  @override
  List<Object?> get props => [isLoading, notifications];
}
