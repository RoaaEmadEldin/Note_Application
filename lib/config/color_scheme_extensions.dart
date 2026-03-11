import 'package:flutter/material.dart';
import 'package:notes_app/config/dark_theme.dart';
import 'package:notes_app/config/light_theme.dart';

extension CustomColorScheme on ColorScheme {
  Color get warning =>
      brightness == Brightness.light ? LightTheme.warning : DarkTheme.warning;
  Color get onWarning => Colors.white;

  Color get textTertiary =>
      brightness == Brightness.light
          ? LightTheme.textTertiary
          : DarkTheme.textTertiary;

  Color get textSecondary =>
      brightness == Brightness.light
          ? LightTheme.textSecondary
          : DarkTheme.textSecondary;

  Color get textDisabled =>
      brightness == Brightness.light
          ? LightTheme.textDisabled
          : DarkTheme.textDisabled;

  Color get cardBackground =>
      brightness == Brightness.light ? LightTheme.card : DarkTheme.card;

  Color get borderColor =>
      brightness == Brightness.light ? LightTheme.border : DarkTheme.border;

  Color get snackBarBackground =>
      brightness == Brightness.light ? LightTheme.textPrimary : DarkTheme.card;

  // Note Colors
  List<Color> get noteColors =>
      brightness == Brightness.light
          ? LightTheme.noteColors
          : DarkTheme.noteColors;
  List<Color> get noteBorderColors => LightTheme.noteBorderColors;

  // Category Colors Map
  Map<String, Color> get categoryColors =>
      brightness == Brightness.light
          ? LightTheme.categoryColors
          : DarkTheme.categoryColors;

  // Helper to get category color by name
  Color getCategoryColor(String? category) {
    if (category == null || category.isEmpty) return primary;
    return categoryColors[category] ?? primary;
  }

  // Helper to get note color by index
  Color getNoteColor(int index) {
    return noteColors[index % noteColors.length];
  }

  // Helper to get note border color by index
  Color getNoteBorderColor(int index) {
    return noteBorderColors[index % noteBorderColors.length];
  }
}
