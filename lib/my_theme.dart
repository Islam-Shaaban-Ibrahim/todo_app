import 'package:flutter/material.dart';

class AppTheme {
  static Color primaryColor = Color(0xff5D9CEC);
  static Color taskDarkColor = Color(0xff141922);
  static Color backgroundColor = Color(0xffDFECDB);
  static Color backgroundDarkColor = Color(0xff060E1E);
  static Color blackColor = Color(0xff060E1E);
  static Color redColor = Color(0xffEC4B4B);
  static Color whiteColor = Color(0xffffffff);
  static Color greyColor = Color.fromARGB(255, 96, 97, 98);
  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: primaryColor, unselectedItemColor: greyColor),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor, foregroundColor: whiteColor),
    textTheme: TextTheme(
      // appBar theme
      titleLarge: TextStyle(
          fontSize: 22, fontWeight: FontWeight.bold, color: whiteColor),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: Colors.transparent,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        backgroundColor: taskDarkColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: greyColor),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor, foregroundColor: whiteColor),
    textTheme: TextTheme(
      // appBar theme
      titleLarge: TextStyle(
          fontSize: 22, fontWeight: FontWeight.bold, color: blackColor),
    ),
  );
}
