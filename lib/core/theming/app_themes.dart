import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppThemes {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'SpaceGrotesk',
      scaffoldBackgroundColor: AppColors.primaryColorDark,
      primaryColor: AppColors.primaryColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryColorDark,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: AppColors.white),
        titleTextStyle: TextStyle(
          color: AppColors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          fontFamily: 'SpaceGrotesk',
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonColorDark,
          foregroundColor: AppColors.white,
        ),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'SpaceGrotesk',
      scaffoldBackgroundColor: AppColors.lightBackground,
      primaryColor: AppColors.primaryColorLight,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: AppColors.darkText),
        titleTextStyle: TextStyle(
          color: AppColors.darkText,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          fontFamily: 'SpaceGrotesk',
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonColorLight,
          foregroundColor: AppColors.darkText,
        ),
      ),
    );
  }
}
