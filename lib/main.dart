import 'dart:async';
import 'dart:collection';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:ivitasa_app/app_root.dart';
import 'package:ivitasa_app/core/services/injection/app_injection.dart';
import 'package:provider/provider.dart';
import 'core/constants/codes_resources.dart';
import 'core/constants/colors_resources.dart';
import 'core/constants/links_resources.dart';
import 'core/services/messaging/messaging/firebase_messaging_client.dart';
import 'services/cache_service.dart';
import 'states/local/local_provider.dart';

bool isAppEnglish = false;

//

void main() async {
  //
  WidgetsFlutterBinding.ensureInitialized();
  //
  await CacheService.init();
  //
  ServiceLocator.init();
  //
  isAppEnglish = CacheService().getBool("is_english") ?? false;
  //
  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
  }
  //
  ///
  /// init firebase && messaging services
  try {
    await Firebase.initializeApp();
    await FirebaseMessagingService().initialize();
  } on Exception catch (e) {}
  //
  runApp(
    ChangeNotifierProvider(
      create: (_) => LocalProvider(),
      child: AppRoot(),
    ),
  );
}
