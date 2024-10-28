part of './../../core/helpers/export_manager/export_manager.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;
  String currentLanguage = 'ar';

  void changeLanguage(String newLanguage) async {
    final pref = await SharedPreferences.getInstance();
    if (currentLanguage == newLanguage) return;
    currentLanguage = newLanguage;
    await pref.setString('Lang', currentLanguage);

    notifyListeners();
  }

  void changeTheme(ThemeMode newMode) async {
    final pref = await SharedPreferences.getInstance();
    if (newMode == currentTheme) return;
    currentTheme = newMode;
    await pref.setString(
        'Theme', currentTheme == ThemeMode.light ? 'Light' : 'Dark');
    notifyListeners();
  }

  bool isDarkMode() {
    return currentTheme == ThemeMode.dark;
  }

  void refreshApp() {
    notifyListeners();
  }
}
