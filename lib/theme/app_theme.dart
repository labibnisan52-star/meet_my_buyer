import 'package:flutter/material.dart';

class AppTheme {
  // Golden Colors
  static const Color primaryGold = Color(0xFFFFD700);
  static const Color secondaryGold = Color(0xFFB8860B);
  
  // Background Colors
  static const Color scaffoldBackground = Color(0xFFF5F6FA);
  static const Color cardColor = Colors.white;

  // Text Colors
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Colors.grey;

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryGold,
      scaffoldBackgroundColor: scaffoldBackground,
      cardColor: cardColor,
      colorScheme: const ColorScheme.light(
        primary: primaryGold,
        secondary: secondaryGold,
        surface: cardColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: textPrimary),
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: secondaryGold,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      iconTheme: const IconThemeData(
        color: textPrimary,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: textPrimary),
        bodyMedium: TextStyle(color: textPrimary),
        titleLarge: TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
      ),
    );
  }
}
