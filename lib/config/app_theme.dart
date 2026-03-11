import 'package:flutter/material.dart';
import 'light_theme.dart';
import 'dark_theme.dart';

class AppTheme {
  AppTheme._();

  // Export color schemes for direct access
  static const ColorScheme lightColorScheme = LightTheme.colorScheme;
  static const ColorScheme darkColorScheme = DarkTheme.colorScheme;

  // Exporting custom colors that are not in the theme for direct access
  // Note Colors
  static const List<Color> noteColorsLight = LightTheme.noteColors;
  static const List<Color> noteColorsDark = DarkTheme.noteColors;
  static const List<Color> noteBorderColors = LightTheme.noteBorderColors;

  // Category colors
  static const Map<String, Color> categoryColorsLight =
      LightTheme.categoryColors;
  static const Map<String, Color> categoryColorsDark = DarkTheme.categoryColors;

  // Main theme methods
  static ThemeData lightTheme() => _buildTheme(
    brightness: Brightness.light,
    colorScheme: lightColorScheme,
    textTheme: _buildTextTheme(lightColorScheme),
    background: LightTheme.background,
    surface: LightTheme.surface,
    card: LightTheme.card,
    border: LightTheme.border,
    primary: LightTheme.primary,
  );

  static ThemeData darkTheme() => _buildTheme(
    brightness: Brightness.dark,
    colorScheme: darkColorScheme,
    textTheme: _buildTextTheme(darkColorScheme),
    background: DarkTheme.background,
    surface: DarkTheme.surface,
    card: DarkTheme.card,
    border: DarkTheme.border,
    primary: DarkTheme.primary,
  );

  static ThemeData _buildTheme({
    required Brightness brightness,
    required ColorScheme colorScheme,
    required TextTheme textTheme,
    required Color background,
    required Color surface,
    required Color card,
    required Color border,
    required Color primary,
  }) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      textTheme: textTheme,
      fontFamily: 'Poppins',
      scaffoldBackgroundColor: background,
      cardColor: card,
      dividerColor: border,
      disabledColor:
          brightness == Brightness.light
              ? LightTheme.textDisabled
              : DarkTheme.textDisabled,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.headlineMedium,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: card,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 4,
        shape: const CircleBorder(),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: border, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colorScheme.error, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        labelStyle: TextStyle(
          color:
              brightness == Brightness.light
                  ? LightTheme.textTertiary
                  : DarkTheme.textTertiary,
          fontFamily: 'Poppins',
        ),
        hintStyle: TextStyle(
          color:
              brightness == Brightness.light
                  ? LightTheme.textDisabled
                  : DarkTheme.textDisabled,
          fontFamily: 'Poppins',
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.primary.withValues(alpha: 0.1),
        labelStyle: TextStyle(
          color: colorScheme.primary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide.none,
      ),
      dividerTheme: DividerThemeData(color: border, thickness: 1),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: card,
        contentTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontFamily: 'Poppins',
          fontSize: 14,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static TextTheme _buildTextTheme(ColorScheme colorScheme) {
    return TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: colorScheme.onSurface,
        fontFamily: 'Poppins',
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: colorScheme.onSurface,
        fontFamily: 'Poppins',
      ),
      headlineSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
        fontFamily: 'Poppins',
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
        fontFamily: 'Poppins',
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurface,
        fontFamily: 'Poppins',
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurface.withValues(alpha: 0.8),
        fontFamily: 'Poppins',
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurface.withValues(alpha: 0.8),
        fontFamily: 'Poppins',
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurface.withValues(alpha: 0.6),
        fontFamily: 'Poppins',
      ),
    );
  }
}
