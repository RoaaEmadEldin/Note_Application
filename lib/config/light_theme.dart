import 'package:flutter/material.dart';

class LightTheme {
  // Brand Colors
  static const Color primary = Color(0xFF6C63FF);
  static const Color secondary = Color(0xFFFF6584);
  static const Color tertiary = Color(0xFF43E97B);
  static const Color warning = Color(0xFFFFB347);

  // Background & Surface Colors
  static const Color background = Color(0xFFF0EFFF);
  static const Color surface = Color(0xFFF8F7FF);
  static const Color card = Color(0xFFFFFFFF);

  // Text Colors
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF3D3D5C);
  static const Color textTertiary = Color(0xFF8B8BA7);
  static const Color textDisabled = Color(0xFFB0B0C8);

  // Border & Divider
  static const Color border = Color(0xFFE0DEFF);
  static const Color divider = Color(0xFFE0DEFF);

  // Note Card Colors
  static const List<Color> noteColors = [
    Color(0xFFFFE0E6), // Pink
    Color(0xFFE0F0FF), // Blue
    Color(0xFFE0FFE8), // Green
    Color(0xFFFFF8E0), // Yellow
    Color(0xFFF0E0FF), // Purple
    Color(0xFFFFEDE0), // Orange
    Color(0xFFE0FFFE), // Teal
    Color(0xFFFFE0F8), // Magenta
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
    'Personal': Color(0xFF6C63FF),
    'Work': Color(0xFF43E97B),
    'Ideas': Color(0xFFFFB347),
    'Important': Color(0xFFFF6584),
    'Study': Color(0xFF00C9C8),
    'Other': Color(0xFFB06CFF),
  };

  static const ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: Colors.white,
    secondary: secondary,
    onSecondary: Colors.white,
    tertiary: tertiary,
    onTertiary: Colors.white,
    error: secondary,
    onError: Colors.white,
    surface: surface,
    onSurface: textPrimary,
    surfaceContainerHighest: card,
    outline: border,

  );
}
