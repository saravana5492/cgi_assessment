import 'package:cgi_assessment/core/theme/color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final darkThemeData = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundColor,
      surfaceTintColor: Colors.transparent,
    ),
  );
}
