import 'package:flutter/material.dart';

class DarkTheme {
  // Brand Colors (adjusted for dark mode)
  static const Color primary = Color(0xFF9D97FF);
  static const Color secondary = Color(0xFFFF8FA3);
  static const Color tertiary = Color(0xFF5EFFA0);
  static const Color warning = Color(0xFFFFB347);

  // Background & Surface Colors
  static const Color background = Color(0xFF12101E);
  static const Color surface = Color(0xFF1E1B2E);
  static const Color card = Color(0xFF1E1B2E);

  // Text Colors
  static const Color textPrimary = Color(0xFFF0EFFF);
  static const Color textSecondary = Color(0xFFB8B8D0);
  static const Color textTertiary = Color(0xFF8B8BA7);
  static const Color textDisabled = Color(0xFF5A5A7A);

  // Border & Divider
  static const Color border = Color(0xFF2E2B45);
  static const Color divider = Color(0xFF2E2B45);

  // Note Card Colors (darker versions)
  static const List<Color> noteColors = [
    Color(0xFF4A1528), // Pink dark
    Color(0xFF0D2B45), // Blue dark
    Color(0xFF0D3320), // Green dark
    Color(0xFF3D3000), // Yellow dark
    Color(0xFF2A0D45), // Purple dark
    Color(0xFF3D1A00), // Orange dark
    Color(0xFF003D3A), // Teal dark
    Color(0xFF3D0030), // Magenta dark
  ];

  static const List<Color> noteBorderColors = [
    Color(0xFFFF6584),
    Color(0xFF6C9EFF),
    Color(0xFF43E97B),
    Color(0xFFFFD700),
    Color(0xFFB06CFF),
    Color(0xFFFF8C42),
    Color(0xFF00C9C8),
    Color(0xFFFF6CE8),
  ];

  // Category Colors
  static const Map<String, Color> categoryColors = {
    'Personal': Color(0xFF9D97FF),
    'Work': Color(0xFF5EFFA0),
    'Ideas': Color(0xFFFFB347),
    'Important': Color(0xFFFF8FA3),
    'Study': Color(0xFF00C9C8),
    'Other': Color(0xFFB06CFF),
  };

  static const ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: primary,
    onPrimary: background,
    secondary: secondary,
    onSecondary: background,
    tertiary: tertiary,
    onTertiary: background,
    error: secondary,
    onError: background,
    surface: surface,
    onSurface: textPrimary,
    surfaceContainerHighest: card,
    outline: border,
  );
}
