import 'dart:convert';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsApi {
  static final _notification = FlutterLocalNotificationsPlugin();

  static Future init({bool initScheduled = false}) async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      "Reminders",
      "Reminders Channel",
    );
    const iosSettings = DarwinInitializationSettings();
    const androidSettings = AndroidInitializationSettings("icon");
    const settings = InitializationSettings(
      iOS: iosSettings,
      android: androidSettings,
    );
    await requestNotificationPermission();
    await _notification.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
    await _notification.initialize(settings);
  }

  static Future<void> requestNotificationPermission() async {
    var status = await Permission.notification.status;
    if (status.isDenied) {
      await Permission.notification.request();
    }
  }

  static showNotificationa({
    required int id,
    String? title,
    String? body,
    String? payload,
  }) async {
    _notification.show(
      0,
      title,
      body,
      await notificationDetails(),
      payload: "",
    );
  }

  static Future showScheduledNotification({
    required AppNotification notification,
  }) async {
    if (notification.date.isBefore(DateTime.now())) {
      // notification = notification.copyWith(
      //   date: DateTime.now().add(
      //     const Duration(seconds: 5),
      //   ),
      // );
      return;
    }
    requestNotificationPermission();
    tz.initializeTimeZones();
    await _notification.zonedSchedule(
      notification.id,
      notification.title,
      notification.body,
      tz.TZDateTime.from(notification.date, tz.local),
      await notificationDetails(),
      payload: notification.getPayload(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: notification.repeated ? DateTimeComponents.time : null,
    );
  }

  static Future cancel({required int id}) async {
    await _notification.cancel(id);
  }

  static Future notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        "Reminders",
        "Reminders Channel",
        importance: Importance.max,
        priority: Priority.max,
        playSound: true,
        enableVibration: true,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }
}

class NotificationsDataSource {
  static String notificationsKey = "notifications_key";
  static Future<List<AppNotification>> getNotifications() async {
    //
    final pendingNotificationRequests = await NotificationsApi._notification.pendingNotificationRequests();
    //
    List<AppNotification> notifications = pendingNotificationRequests.map((e) {
      return AppNotification.fromPayload(
        e.id,
        e.body ?? "",
        e.title ?? "",
        e.payload ?? "",
      );
    }).toList();
    notifications.sort(
      (a, b) => a.date.compareTo(b.date),
    );
    return notifications;
  }

  static Future<void> setNotifications(
    List<AppNotification> notifications,
  ) async {
    //
    var sp = await SharedPreferences.getInstance();
    //
    List<String> strList = notifications.map((e) {
      return jsonEncode(e.toJson());
    }).toList();
    //
    await sp.setStringList(notificationsKey, strList);
  }
}

class AppNotification {
  final int id;
  final String title;
  final String body;
  final bool repeated;

  final DateTime date;

  AppNotification({
    required this.id,
    required this.repeated,
    required this.date,
    required this.title,
    required this.body,
  });

  String getPayload() {
    Map data = {"repeated": repeated, "date": date.toString()};
    return json.encode(data);
  }

  AppNotification copyWith({
    int? id,
    DateTime? date,
    String? title,
    String? body,
    bool? reapeted,
  }) {
    return AppNotification(
      id: id ?? this.id,
      repeated: reapeted ?? repeated,
      date: date ?? this.date,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  factory AppNotification.fromJson(Map json) {
    return AppNotification(
      id: json["id"],
      date: DateTime.parse(json["date"]),
      title: json["title"],
      body: json["body"],
      repeated: json["repeated"],
    );
  }
  factory AppNotification.fromPayload(
    int id,
    String body,
    String title,
    String payload,
  ) {
    Map data = jsonDecode(payload);
    return AppNotification(
      id: id,
      title: title,
      body: body,
      date: DateTime.parse(data["date"] ?? DateTime.now().toString()),
      repeated: data["repeated"] ?? false,
    );
  }
  toJson() {
    return {
      "id": id,
      "date": date.toString(),
      "title": title,
      "body": body,
      "reapeted": repeated,
    };
  }
}
