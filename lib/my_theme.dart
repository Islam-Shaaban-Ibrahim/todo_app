import 'package:flutter/material.dart';

class AppTheme {
  static Color primaryColor = const Color(0xff5D9CEC);
  static Color taskDarkColor = const Color(0xff141922);
  static Color backgroundColor = const Color(0xffDFECDB);
  static Color backgroundDarkColor = const Color(0xff060E1E);
  static Color blackColor = const Color(0xff060E1E);
  static Color redColor = const Color(0xffEC4B4B);
  static Color whiteColor = const Color(0xffffffff);
  static Color greyColor = const Color.fromARGB(255, 96, 97, 98);
  static Color greenColor = const Color(0xff61E757);
  static ThemeData lightTheme = ThemeData(
    shadowColor: Colors.transparent,
    splashFactory: InkRipple.splashFactory,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: whiteColor),
      color: Colors.transparent,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        enableFeedback: false,
        selectedItemColor: primaryColor,
        unselectedItemColor: greyColor),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        enableFeedback: false,
        backgroundColor: primaryColor,
        foregroundColor: whiteColor),
    textTheme: TextTheme(
      // appBar theme
      titleLarge: TextStyle(
          fontSize: 22, fontWeight: FontWeight.bold, color: whiteColor),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    splashFactory: InkRipple.splashFactory,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: blackColor),
      elevation: 0,
      color: Colors.transparent,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        enableFeedback: false,
        backgroundColor: taskDarkColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: greyColor),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        enableFeedback: false,
        backgroundColor: primaryColor,
        foregroundColor: whiteColor),
    textTheme: TextTheme(
      // appBar theme
      titleLarge: TextStyle(
          fontSize: 22, fontWeight: FontWeight.bold, color: blackColor),
    ),
  );
}
