import 'package:flutter/material.dart';
import 'package:ivitasa_app/main.dart';

class LocalProvider with ChangeNotifier {
  bool isEnglish = isAppEnglish;

  String get local => isEnglish ? "en" : "ar";

  void toggleLanguage() {
    isEnglish = !isEnglish;
    isAppEnglish = isEnglish;
    notifyListeners();
  }
}
