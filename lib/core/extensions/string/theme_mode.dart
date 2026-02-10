import 'package:flutter/material.dart';

extension ThemeModeExtension on String {
  ThemeMode get toThemeMode {
    switch (toLowerCase()) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
