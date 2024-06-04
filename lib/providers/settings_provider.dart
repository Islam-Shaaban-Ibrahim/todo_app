import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  bool isLoggedIn = false;
  String appLanguage = 'en';
  ThemeMode appTheme = ThemeMode.light;
  bool isDark = false;

  void changeLanguage(String newLang) async {
    var pref = await SharedPreferences.getInstance();
    appLanguage = newLang;
    pref.setString("lang", newLang);
    notifyListeners();
  }

  void changeTheme(ThemeMode newTheme) async {
    var pref = await SharedPreferences.getInstance();
    appTheme = newTheme;
    pref.setBool("dark", appTheme == ThemeMode.dark ? true : false);
    notifyListeners();
  }

  void changeLoginStatus() async {
    var pref = await SharedPreferences.getInstance();
    isLoggedIn = !isLoggedIn;
    pref.setBool("log", isLoggedIn);
    notifyListeners();
  }

  void getAllPrefs() async {
    var pref = await SharedPreferences.getInstance();
    if (pref.getBool("log") != null) {
      isLoggedIn = pref.getBool("log")!;
    }
    if (pref.getString("lang") != null) {
      appLanguage = pref.getString("lang")!;
    }
    if (pref.getBool("dark") != null) {
      if (pref.getBool("dark")!) {
        appTheme = ThemeMode.dark;
        isDark = true;
      } else {
        appTheme = ThemeMode.light;
        isDark = false;
      }
    }

    notifyListeners();
  }
}
