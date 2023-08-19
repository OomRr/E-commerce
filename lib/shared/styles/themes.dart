import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData buildThemeDataLight() {
  return ThemeData(
    primarySwatch: defaultColor,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      elevation: 20,
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: defaultColor),
    useMaterial3: true,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 18,

      ),
    ),
    fontFamily: 'Janna',
  );
}

ThemeData buildThemeDataDark() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.black,
    primarySwatch: defaultColor,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      elevation: 40,
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: defaultColor),
    useMaterial3: true,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
    ),
    fontFamily: 'Janna',
  );
}



