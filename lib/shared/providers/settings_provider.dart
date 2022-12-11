import 'package:flutter/material.dart';


class SettingsProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;
  String currentLanguage = 'en';

  void changeLanguage(String newLanguage)
  {
    currentLanguage = newLanguage;
    notifyListeners();
  }

  // observable pattern

  void changeTheme(ThemeMode newMode) {
    currentTheme = newMode;
    notifyListeners();
  }

  // String getBackgroundImage() {
  //   return currentTheme == ThemeMode.light
  //       ? AssetsPath.backgroundLight
  //       : AssetsPath.backgroundDark;
  // }


  bool isDarkMode() {
    return currentTheme == ThemeMode.dark;
  }
}

