import 'package:farego/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    /// Color scheme
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
      error: AppColors.error,
      onPrimary: Colors.black,
      onSecondary: Colors.white,
      onSurface: AppColors.onSurface,
      onError: Colors.white,
    ),

    /// Scaffold
    scaffoldBackgroundColor: const Color.fromARGB(255, 249, 248, 248),

    /// App theme
    appBarTheme: AppBarTheme(
      elevation: 2,
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.black12,
      centerTitle: true,
    ),

    /// Icon Data
    iconTheme: IconThemeData(color: Colors.grey[600]),

    /// Input theme
    inputDecorationTheme: InputDecorationTheme().copyWith(
      filled: true,
      fillColor: Colors.white70,
      floatingLabelStyle: const TextStyle(
        color: Colors.grey,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      isDense: true,
      labelStyle: const TextStyle(
        color: Colors.grey,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        wordSpacing: 3.0,
      ),
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
      border: const OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color.fromARGB(207, 139, 139, 139)),
        borderRadius: .circular(8.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color.fromARGB(248, 224, 224, 224)),
        borderRadius: .circular(8.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color.fromARGB(255, 251, 17, 0)),
        borderRadius: .circular(8.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color.fromARGB(255, 255, 17, 0)),
        borderRadius: .circular(8.0),
      ),
      errorMaxLines: 2,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: Color(0xFF9CA3AF),
      surface: Color(0xFF1E1E1E),
      error: Color(0xFFF87171),
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: Colors.white,
      onError: Colors.black,
    ),

    /// Scaffold
    scaffoldBackgroundColor: Color(0xFF121212),
  );
}
