import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = 'theme_mode';
  static const String _colorKey = 'theme_color';

  bool _isDarkMode = false;
  Color _seedColor = Colors.blue;

  final List<Color> colorOptions = [
    Colors.blue,
    Colors.purple,
    Colors.green,
    Colors.orange,
    Colors.pink,
    Colors.teal,
    Colors.indigo,
    Colors.red,
  ];

  ThemeProvider() {
    _loadPreferences();
  }

  bool get isDarkMode => _isDarkMode;
  Color get seedColor => _seedColor;

  Future<void> _loadPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isDarkMode = prefs.getBool(_themeKey) ?? false;
      final colorIndex = prefs.getInt(_colorKey) ?? 0;
      _seedColor = colorOptions[colorIndex];
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading preferences: $e');
    }
  }

  Future<void> toggleTheme() async {
    try {
      _isDarkMode = !_isDarkMode;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_themeKey, _isDarkMode);
      notifyListeners();
    } catch (e) {
      debugPrint('Error toggling theme: $e');
    }
  }

  Future<void> setThemeColor(Color color) async {
    try {
      if (_seedColor != color) {
        _seedColor = color;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt(_colorKey, colorOptions.indexOf(color));
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error setting theme color: $e');
    }
  }
}
