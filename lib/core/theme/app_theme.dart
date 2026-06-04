import 'package:flutter/material.dart';
import 'package:houzeo_task/core/constant/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: AppColors.background,

    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),

    appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0),
  );
}
