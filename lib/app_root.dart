import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ivitasa_app/core/constants/codes_resources.dart';
import 'package:ivitasa_app/main.dart';
import 'package:provider/provider.dart';
import 'core/constants/colors_resources.dart';
import 'core/constants/headlesswebview_resources.dart';
import 'screens/pages_holder_view.dart';
import 'screens/start/splash_view.dart';
import 'states/local/local_provider.dart';

class AppRoot extends StatelessWidget {
  const AppRoot._internal();

  static const AppRoot _instance = AppRoot._internal();

  factory AppRoot() => _instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ivita',
      theme: ThemeData(
        fontFamily: "Cairo",
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColorsResources.primaryColor,
        ),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      supportedLocales: context.watch<LocalProvider>().isEnglish ? const [Locale("en")] : const [Locale("ar")],
      home: SplashView(),
    );
  }
}
