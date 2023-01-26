import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeApp {
  static const Color lightPrimary = Color(0xff5D9CEC);
  static const Color darkPrimary = Color(0xff060E1E);
  static const Color darkBottom = Color(0xff141922);
  static const Color grey = Color(0xffC8C9CB);
  static const Color scaffoldBackgroundColorLight = Color(0xffDFECDB);
  static const Color scaffoldBackgroundColorDark = Color(0xff060E1E);

  static final ThemeData lightTheme = ThemeData(
    primaryColor: lightPrimary,
    scaffoldBackgroundColor: scaffoldBackgroundColorLight,
    bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18), topRight: Radius.circular(18)))),
    cardColor: Colors.white,
    textTheme: const TextTheme(
        headline6: TextStyle(
          fontSize: 24,
          color: lightPrimary,
        ),
        headline5: TextStyle(
          fontSize: 30,
          color: lightPrimary,
        ),

        subtitle2: TextStyle(fontSize: 14, color:Colors.grey)),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      color: lightPrimary,
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 32, fontWeight: FontWeight.w500),
      iconTheme: IconThemeData(color: Colors.black),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
      actionsIconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 0,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(size: 46, color: lightPrimary),
        unselectedIconTheme: IconThemeData(size: 40, color: grey),
        selectedLabelStyle: TextStyle(color: Colors.black),
        selectedItemColor: Colors.black),
  );

  static final ThemeData darkTheme = ThemeData(

    scaffoldBackgroundColor: scaffoldBackgroundColorDark,
    primaryColor: darkPrimary,
    bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: darkPrimary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18), topRight: Radius.circular(18)))),
    textTheme: const TextTheme(
        headline6: TextStyle(
          fontSize: 22,
          color: Colors.white,
        ),
        headline4: TextStyle(
          fontSize: 28,
          color: Colors.white,
        ),
        subtitle2: TextStyle(fontSize: 14, color: Colors.white)),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: lightPrimary,
      elevation: 0,
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 32, fontWeight: FontWeight.w500),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: darkBottom,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(size: 46, color: lightPrimary),
        unselectedIconTheme: IconThemeData(size: 40, color: grey),
        selectedLabelStyle: TextStyle(color: Colors.black),
        selectedItemColor: Colors.black),
  );
}