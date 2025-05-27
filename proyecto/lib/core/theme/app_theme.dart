import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

final ThemeData appTheme = ThemeData(
  fontFamily: AppTextStyles.fontFamily,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  colorScheme: ColorScheme.light(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    error: AppColors.accent,
    background: AppColors.background,
    onPrimary: AppColors.background,
    onSecondary: AppColors.background,
    onError: AppColors.background,
    onBackground: AppColors.text,
    surface: AppColors.background,
    onSurface: AppColors.text,
  ),
  textTheme: TextTheme(
    headlineLarge: AppTextStyles.headline,
    titleLarge: AppTextStyles.title,
    bodyMedium: AppTextStyles.body,
    labelLarge: AppTextStyles.button,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: AppTextStyles.button,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: AppColors.info),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: AppColors.primary, width: 2),
    ),
    labelStyle: TextStyle(color: AppColors.info),
    hintStyle: TextStyle(color: AppColors.info.withOpacity(0.7)),
  ),
);
