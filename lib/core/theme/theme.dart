import 'package:flutter/material.dart';
import 'package:new_bloc_clean_app/core/theme/app_pallete.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 3),
      borderRadius: BorderRadius.circular(10));
  static final darkMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.backgroundColor,
    ),
    chipTheme: const ChipThemeData(
        side: BorderSide.none,
        color: MaterialStatePropertyAll(AppPallete.backgroundColor)),
    inputDecorationTheme: InputDecorationTheme(
        focusedBorder: _border(AppPallete.gradient1),
        contentPadding: const EdgeInsets.all(27),
        enabledBorder: _border()),
  );
}
