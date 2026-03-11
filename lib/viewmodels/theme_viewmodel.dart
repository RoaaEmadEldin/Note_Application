import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeViewModel extends ChangeNotifier {
  static final String _boxName = 'settingsBox';
  static const String _themeKey = 'theme_mode';

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  ThemeViewModel() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    try {
      final box = await Hive.openBox(_boxName);
      final saved = box.get(_themeKey, defaultValue: 'system') as String;
      _themeMode = switch (saved) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      };
      notifyListeners();
    } catch (e) {
      _themeMode = ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();

    try {
      final box = await Hive.openBox(_boxName);
      await box.put(_themeKey, switch (mode) {
        ThemeMode.light => 'light',
        ThemeMode.dark => 'dark',
        _ => 'system',
      });
    } catch (e) {
      _errorMessage = 'Failed to save theme preference.';
      notifyListeners();
    }
  }
}
