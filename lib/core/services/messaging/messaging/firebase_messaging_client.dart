import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'firebase_messaging_handlers.dart';

class FirebaseMessagingService {
  Future<void> initialize() async {
    ///
    final instance = FirebaseMessaging.instance;
    await instance.requestPermission();

    ///
    await instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    ///
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    ///
    FirebaseMessaging.onMessage.listen(
      onData,
      onDone: onDone,
      onError: onError,
    );

    ///
    FirebaseMessaging.instance.onTokenRefresh.listen(onTokenRefreshed);

    ///
    debugPrint("device token ${await getDeviceToken()}");

    ///
    return;
  }

  Future<void> subscribeToTopic(String topic) async {
    await FirebaseMessaging.instance.subscribeToTopic(topic);
    return;
  }

  Future<String?> getDeviceToken() async {
    String? token;
    if (Platform.isIOS) {
      token = await FirebaseMessaging.instance.getAPNSToken();
    } else {
      token = await FirebaseMessaging.instance.getToken();
    }
    return token;
  }
}
