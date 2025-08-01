import 'package:flutter/material.dart';

abstract final class AppColors {
  // Backgrounds
  static const backgroundPrimary = Color(0xFF000000);
  static const backgroundSecondary = Color(0xFF575757);
  static const backgroundTertiary = Color(0xFF8B8B8B);
  static const backgroundLoginPrimary = Color(0xFF39ADE5);

  // Icon
  static const icon = Color(0xFFB6B6B6);

  // Text
  static const textPrimary = Color(0xFFFFFFFF);
  static const textAlert = Color(0xFFFF0000);
  static const textGetPremium = Color(0xFF034694);
  static const textSecondary = Color(0xFFBCBCBC);

  // Button
  static const buttonGetPremium = Color(0xFF0D47A1);
  static const buttonLoginPrimary = Color(0xFFFFFFFF);
  static const buttonLoginPressed = Color(0xFF1899E5);

  // State
  static const stateActive = Color(0xFF0B9F5D);

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.backgroundPrimary,
    onPrimary: AppColors.textSecondary,
    secondary: AppColors.backgroundSecondary,
    onSecondary: AppColors.textSecondary,
    surface: AppColors.backgroundPrimary,
    onSurface: Colors.white,
    error: Colors.black,
    onError: AppColors.textAlert,
  );
}
