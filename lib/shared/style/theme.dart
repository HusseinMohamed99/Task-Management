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

  static final ThemeData lightTheme = ThemeData(
    primaryColor: lightPrimary,
    scaffoldBackgroundColor: scaffoldBackgroundColorLight,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ).r,
      ),
    ),
    cardColor: Colors.white,
    textTheme: TextTheme(
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
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      color: lightPrimary,
      titleTextStyle: TextStyle(
        color: Colors.white,
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
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(
        size: 35.sp,
        color: lightPrimary,
      ),
      unselectedIconTheme: IconThemeData(
        size: 30.sp,
        color: grey,
      ),
      selectedLabelStyle: const TextStyle(
        color: Colors.black,
      ),
      selectedItemColor: Colors.black,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: scaffoldBackgroundColorDark,
    primaryColor: darkPrimary,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: darkPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ).r,
      ),
    ),
    textTheme: TextTheme(
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
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: lightPrimary,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 32.sp,
        fontWeight: FontWeight.w500,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: darkBottom,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(
        size: 35.sp,
        color: lightPrimary,
      ),
      unselectedIconTheme: IconThemeData(
        size: 30.sp,
        color: grey,
      ),
      selectedLabelStyle: const TextStyle(
        color: Colors.black,
      ),
      selectedItemColor: Colors.black,
    ),
  );
}
