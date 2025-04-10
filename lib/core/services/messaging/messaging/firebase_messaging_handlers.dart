import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ivitasa_app/services/cache_service.dart';
import '../../../../states/notifications/notifications_bloc.dart';
import '../../injection/app_injection.dart';
import '../notifications_api.dart';

///
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  ///
  await Firebase.initializeApp();

  ///
  ServiceLocator.init();

  ///
  await NotificationsApi.init();

  ///
  await CacheService.init();

  /// debugging :
  ///
  List<Notification> notifications = await getNotifications();
  debugPrint('notifications.length before : ${notifications.length}');
  //
  notifications.insert(0, Notification.fromRemoteMessage(message));
  debugPrint('notifications.length after : ${notifications.length}');
  //
  await setNotifications(notifications);

  return;
}

///
void onData(RemoteMessage message) async {
  ///
  await NotificationsApi.init();

  ///
  await NotificationsApi.showNotificationa(
    id: DateTime.now().second,
    title: message.notification?.title,
    body: message.notification?.body,
    payload: message.data.toString(),
  );

  ///
  List<Notification> notifications = await getNotifications();
  notifications.insert(0, Notification.fromRemoteMessage(message));
  await setNotifications(notifications);
  sl<NotificationsBloc>().add(InitializeNotificationsEvent());
}

///
void onTokenRefreshed(String newToken) async {}

///
void onDone() {}

///
void onError(error) {}

class Notification {
  final String? id;
  final String? title;
  final String? body;

  Notification({
    required this.id,
    required this.title,
    required this.body,
  });

  factory Notification.fromRemoteMessage(RemoteMessage remoteMessage) {
    return Notification(
      id: remoteMessage.messageId,
      title: remoteMessage.notification?.title,
      body: remoteMessage.notification?.body,
    );
  }

  factory Notification.fromJson(Map json) {
    return Notification(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }
}

@pragma('vm:entry-point')
Future<List<Notification>> getNotifications() async {
  List<String> localData = CacheService().getStringList('notifications') ?? [];
  List<Notification> notifications = localData.map((e) {
    return Notification.fromJson(json.decode(e));
  }).toList();
  return notifications;
}

@pragma('vm:entry-point')
Future<void> setNotifications(List<Notification> notifications) async {
  try {
    List<String> localData = notifications.map((e) => json.encode(e.toJson())).toList();
    await CacheService().setStringList('notifications', (localData));
    debugPrint('setNotifications success');
  } on Exception catch (e) {
    debugPrint('setNotifications error : $e');
  }
}
