import 'package:flutter/material.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    primarySwatch: Colors.green,
    primaryColor: const Color(0xFF075E54),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF075E54),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
    ),
    tabBarTheme: const TabBarThemeData(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white70,
      indicatorColor: Colors.white,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF25D366),
    ),
  );

  static final darkTheme = ThemeData.dark().copyWith(
    primaryColor: const Color(0xFF1F2C33),
    scaffoldBackgroundColor: const Color(0xFF121B22),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1F2C33),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
    ),
    tabBarTheme: const TabBarThemeData(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white60,
      indicatorColor: Color(0xFF00A884),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF25D366),
    ),
  );
}
