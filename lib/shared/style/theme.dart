import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeApp {
  static const Color secondaryColor = Colors.blueAccent;

  static const Color lightPrimary = Color(0xff5D9CEC);
  static const Color darkPrimary = Color(0xff060E1E);
  static const Color darkBottom = Color(0xff141922);
  static const Color grey = Color(0xffC8C9CB);
  static const Color scaffoldBackgroundColorLight = Color(0xffDFECDB);
  static const Color scaffoldBackgroundColorDark = Color(0xff060E1E);

  static final ThemeData lightTheme = _buildLightTheme();
  static final ThemeData darkTheme = _buildDarkTheme();

  static ThemeData _buildLightTheme() {
    return ThemeData(
      primaryColor: lightPrimary,
      scaffoldBackgroundColor: scaffoldBackgroundColorLight,
      bottomSheetTheme: _bottomSheetTheme(Colors.white),
      cardColor: Colors.white,
      textTheme: _lightTextTheme(),
      appBarTheme: _appBarTheme(lightPrimary, Colors.white),
      bottomNavigationBarTheme: _bottomNavigationBarTheme(),
    );
  }

  static ThemeData _buildDarkTheme() {
    return ThemeData(
      scaffoldBackgroundColor: scaffoldBackgroundColorDark,
      primaryColor: darkPrimary,
      bottomSheetTheme: _bottomSheetTheme(darkPrimary),
      textTheme: _darkTextTheme(),
      appBarTheme: _appBarTheme(lightPrimary, Colors.white),
      bottomNavigationBarTheme: _bottomNavigationBarTheme(),
    );
  }

  static BottomSheetThemeData _bottomSheetTheme(Color backgroundColor) {
    return BottomSheetThemeData(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ).r,
      ),
    );
  }

  static TextTheme _lightTextTheme() {
    return TextTheme(
      titleLarge: TextStyle(
        fontSize: 24.sp,
        color: lightPrimary,
      ),
      headlineSmall: TextStyle(
        fontSize: 30.sp,
        color: lightPrimary,
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp,
        color: Colors.grey,
      ),
    );
  }

  static TextTheme _darkTextTheme() {
    return TextTheme(
      titleLarge: TextStyle(
        fontSize: 22.sp,
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        fontSize: 28.sp,
        color: Colors.white,
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp,
        color: Colors.white,
      ),
    );
  }

  static AppBarTheme _appBarTheme(Color backgroundColor, Color titleColor) {
    return AppBarTheme(
      elevation: 0,
      centerTitle: true,
      color: backgroundColor,
      titleTextStyle: TextStyle(
        color: titleColor,
        fontSize: 32.sp,
        fontWeight: FontWeight.w500,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
        size: 24.sp,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      actionsIconTheme: const IconThemeData(
        color: Colors.white,
      ),
    );
  }

  static BottomNavigationBarThemeData _bottomNavigationBarTheme(
      [Color? backgroundColor]) {
    return BottomNavigationBarThemeData(
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: 0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(
        size: 24.sp,
        color: lightPrimary,
      ),
      unselectedIconTheme: IconThemeData(
        size: 20.sp,
        color: grey,
      ),
      selectedLabelStyle: const TextStyle(
        color: Colors.black,
      ),
      selectedItemColor: Colors.black,
    );
  }
}
